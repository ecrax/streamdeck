# Getting Started

### Download

- Go to the [GitHub releases](https://github.com/ecrax/streamdeck/releases) section and download the newest stable release on / for your phone.

- Download the Python script that comes with the newest stable release from the [GitHub releases](https://github.com/ecrax/streamdeck/releases) section.

### Install

#### Phone

- Install the downloaded apk or plist file (depending on your phone OS). You may have to do some additional configuration, because it is an app that is not on the Google Play Store nor on the Apple App Store.

?> On Android to install from unknown sources you can follow [this](https://www.verizon.com/support/knowledge-base-222186/) guide.

?> On iOS you may have to do something similar to [this](https://support.doforms.com/hc/en-us/articles/204409074-How-to-download-and-install-the-iOS-app-from-the-doForms-website#:~:text=From%20the%20web%20browser%20on,%22Untrusted%20Enterprise%20Developer%22%20message.).

#### Computer

- Move the Python script to a safe space on your computer where it will not be deleted (_Downloads_ is not a safe folder!).
- Open OBS, go to **Tools** -> **Scripts**
- In the window that opens, click on the small plus in the bottom left corner and choose the Python script (_server.py_)

!> You may have to add a firewall exception for incomming connections to your OS for the port you want to use.

### Usage

Click on the _Start/Stop Server_ button inside of OBS and leave the two text fields empty for now (Except you have to use a different IP or Port. If you are not sure just leave them empty.).
When clicking on _Script Log_ you should see _Server Started..._ and _Server Running..._ in the console that opens.

Now you can open the Streamdeck app on your mobile device and connect to the values that are displayed or that you entered manually. Then click on _Connect_.

When connected, you are all set up. You can keep using the default layout, or change to another template, by swiping from the very left to right and clicking on one. You can also customize it further.

### Customization

If you want to change the function of a button (for example from switching a scene to muting an audio track), simply long-press a button until a dialog opens. There you can choose from a variety of functions a button can have:

- Muting audio
- Switching to a scene
- Hiding a source
- Toggle your stream on and off
- Toggle your recording on and off
- Pause and resume your recording
- Disconnect / close the connection

Depending on the function you assign, you might e.g. also have to enter the index (starting at 1) of the scene you want the button to switch to or the name of the audio track you want your button to mute/unmute.
