import socket
import threading
import obspython as obs
import sys
import os
import subprocess

c_port = ""
c_ipA = ""
stopServer = False
runServer = True


def getIP():
    LocalIP = socket.gethostbyname_ex(socket.gethostname())
    LocalIP = LocalIP[-1]
    for ip in LocalIP:
        if not ip.endswith(".1"):
            return ip


HEADER = 64
PORT = 7071
ADDR = (getIP(), PORT)
FORMAT = "utf-8"
DISCONNECT_MESSAGE = "stop"


def start():

    print(c_ipA)
    print(c_port)

    # Open Port?
    """
	#open Port
	if (c_port != ""):
		cmd = 'netsh advfirewall firewall add rule name= \"Open Port ' + str(c_port) + '\" dir=in action=allow protocol=TCP localport='+str(c_port)
		#os.system('cmd /k ' + cmd)
		subprocess.call(['runas', '/user:Administrator', cmd])	
	else:
		#cmd = "echo Hello"#"netsh advfirewall firewall add rule name= \"Open Port \" dir=in action=allow protocol=TCP localport=80"
		#os.system('cmd /k ' + cmd)
		pass
	"""
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.settimeout(5)
        if c_ipA != "" and c_port != "":
            print("Connecting with custom ip adress and port...")
            s.bind((c_ipA, int(c_port)))
        elif c_ipA == "" and c_port != "":
            print("Connecting with custom port...")
            s.bind((getIP(), int(c_port)))
        elif c_ipA != "" and c_port == "":
            print("Connecting with custom ip adress...")
            s.bind((c_ipA, PORT))
        else:
            print("Connecting with default values...")
            s.bind(ADDR)
        s.listen()
        print("Server Started...")

        global runServer
        global stopServer
        while runServer:
            print("Server Running...")
            try:
                conn, addr = s.accept()
                conn.settimeout(5)
                with conn:
                    print("connected by", addr)
                    connected = True
                    while connected:
                        try:
                            msg = conn.recv(1024)
                            if not msg:
                                break

                            msg = msg.decode(FORMAT)

                            if "scene" in msg:
                                try:
                                    scene = int(msg[5:])
                                    scenes = obs.obs_frontend_get_scenes()
                                    if len(scenes) >= (scene + 1):
                                        obs.obs_frontend_set_current_scene(
                                            scenes[scene]
                                        )
                                except:
                                    pass
                            elif "s_mute" in msg:
                                try:
                                    msource = str(msg[6:])
                                    source = obs.obs_get_source_by_name(msource)
                                    if source is not None:
                                        obs.obs_source_set_muted(source, True)
                                except:
                                    pass
                            elif "s_unmute" in msg:
                                try:
                                    umsource = str(msg[8:])
                                    source = obs.obs_get_source_by_name(umsource)
                                    if source is not None:
                                        obs.obs_source_set_muted(source, False)
                                except:
                                    pass
                            elif "s_hide" in msg:
                                try:
                                    hsource = str(msg[6:])
                                    source = obs.obs_get_source_by_name(hsource)
                                    if source is not None:
                                        obs.obs_source_set_enabled(source, False)
                                except:
                                    pass
                            elif "s_unhide" in msg:
                                try:
                                    uhsource = str(msg[8:])
                                    source = obs.obs_get_source_by_name(uhsource)
                                    if source is not None:
                                        obs.obs_source_set_enabled(source, True)
                                except:
                                    pass

                            elif "st_start" in msg:
                                try:
                                    obs.obs_frontend_streaming_start()
                                except:
                                    pass
                            elif "st_stop" in msg:
                                try:
                                    obs.obs_frontend_streaming_stop()
                                except:
                                    pass
                            elif "re_start" in msg:
                                try:
                                    obs.obs_frontend_recording_start()
                                except:
                                    pass
                            elif "re_stop" in msg:
                                try:
                                    obs.obs_frontend_recording_stop()
                                except:
                                    pass
                            elif "re_pause" in msg:
                                try:
                                    if obs.obs_frontend_recording_paused():
                                        obs.obs_frontend_recording_pause(False)
                                    else:
                                        obs.obs_frontend_recording_pause(True)
                                except:
                                    pass

                            if "server_stop" in msg:
                                connected = False
                                runServer = False
                                stopServer = False
                        except:
                            if runServer == False:
                                connected = False

                    print("Closing Connection")
                    conn.close()
                    print("Server Stopped...")
                    sys.exit()
            except:
                pass

        print("Server Stopped...")
        sys.exit()


def startstop_server(prps, prop):
    global runServer
    global stopServer
    if stopServer == True:
        print("Stopping Server...")
        stopServer = False
        runServer = False
    else:
        runServer = True
        stopServer = True
        thread = threading.Thread(target=start)
        thread.start()


def script_description():
    return (
        "Connect to "
        + getIP()
        + " on Port "
        + str(PORT)
        + "\n \nor use custom values if you want to use another port or the given ip adress is incorrect:"
    )


def script_update(settings):
    global c_ipA
    global c_port

    c_ipA = obs.obs_data_get_string(settings, "c_ipA")
    c_port = obs.obs_data_get_string(settings, "c_port")


def script_properties():

    props = obs.obs_properties_create()

    obs.obs_properties_add_text(
        props, "c_ipA", "Custom Ip Adress", obs.OBS_TEXT_DEFAULT
    )
    obs.obs_properties_add_text(props, "c_port", "Custom Port", obs.OBS_TEXT_DEFAULT)

    obs.obs_properties_add_button(
        props, "button", "Start/Stop Server", startstop_server
    )

    return props

