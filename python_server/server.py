import socket
import threading
import obspython as obs
import sys
import os
import subprocess

c_port = ""
c_ipA = ""

def getIP():
	LocalIP = socket.gethostbyname_ex(socket.gethostname())
	LocalIP = LocalIP[-1]
	for ip in LocalIP:
		if not ip.endswith(".1"):
			return ip

HEADER = 64
PORT = 7071
ADDR = (getIP(), PORT)
FORMAT = 'utf-8'
DISCONNECT_MESSAGE = "stop"

def start():

	print(c_ipA)
	print(c_port)

	#Open Port?
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
		if (c_ipA != "" and c_port != ""):
			print("Connecting with custom ip adress and port...")
			s.bind((c_ipA, int(c_port)))
		elif (c_ipA == "" and c_port != ""):
			print("Connecting with custom port...")
			s.bind((getIP(), int(c_port)))
		elif (c_ipA != "" and c_port == ""):
			print("Connecting with custom ip adress...")
			s.bind((c_ipA, PORT))
		else:
			print("Connecting with default values...")
			s.bind(ADDR)
		s.listen()
		print("Server Started...")
		conn, addr = s.accept()
		with conn:
			print("connected by", addr)
			while True:
				msg = conn.recv(1024)
				if not msg:
					break
				msg = msg.decode(FORMAT)

				if "scene" in msg:
					scene = int(msg[5:])

					scenes = obs.obs_frontend_get_scenes()
					if(len(scenes) >= (scene+1)):
						obs.obs_frontend_set_current_scene(scenes[scene])
				elif "mute" in msg:
					mchannel = int(msg[4:])
				elif "unmute" in msg:
					umchannel = int(msg[6:])
				elif "hide" in msg:
					hsource = int(msg[4:])
				elif "unhide" in msg:
					uhsource = int(msg[6:])
				elif "stop" in msg:
					print("Stopping Server...")
					conn.close()
					print("Server Stopped...")
					sys.exit()
					

def start_server(props, prop):
	print("Starting Server...")
	thread = threading.Thread(target=start)
	thread.start()

def script_description():
	return "Connect to " + getIP() + " on Port " + str(PORT) + "\n \nor use custom values:"

def script_update(settings):
	global c_ipA
	global c_port

	c_ipA = obs.obs_data_get_string(settings, "c_ipA")
	c_port = obs.obs_data_get_string(settings, "c_port")

def script_defaults(settings):
	pass

def script_properties():
	props = obs.obs_properties_create()

	obs.obs_properties_add_text(props, "c_ipA", "Custom Ip Adress", obs.OBS_TEXT_DEFAULT)
	obs.obs_properties_add_text(props, "c_port", "Custom Port", obs.OBS_TEXT_DEFAULT)

	obs.obs_properties_add_button(props, "button", "Start Server", start_server)
	return props
