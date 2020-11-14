import socket
import threading
import obspython as obs
from tkinter import *
import sys

HEADER = 64
PORT = 6971
SERVER = socket.gethostbyname(socket.gethostname())
ADDR = (SERVER, PORT)
FORMAT = "utf-8"
DISCONNECT_MESSAGE = "stop"


def start():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind(ADDR)
        s.listen()
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
                    if len(scenes) >= (scene + 1):
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
                    conn.close()
                    sys.exit()


def out(o_string):
    window = Tk()

    window.title("Output")
    window.geometry("300x100")

    lbl = Label(window, text=o_string)

    lbl.grid(column=0, row=0)

    window.mainloop()


def start_server(props, prop):
    thread = threading.Thread(target=start)
    thread.start()


def script_description():
    return "Connect to " + str(socket.gethostbyname(socket.gethostname()))


def script_update(settings):
    pass


def script_defaults(settings):
    pass


def script_properties():
    props = obs.obs_properties_create()

    obs.obs_properties_add_button(props, "button", "Start Server", start_server)
    return props
