# WebRTC PC Streamer

The PC Streamer has the patches, prerequisites and steps for testing PC based webrtc streamer using webcam. Instructions added for running peer connection application in two different ubuntu PCs, with webcam connected to one PC. These instructions will get you a copy of the webrtc project code [WebRTC 72 branch checkout] - trimmed for single side streaming, compiled and binaries executed to view the webcam's output in the second PC.

## Instructions to set up PC streamer (gtk trimmed client with webcam)

1. git clone (https://github.com/rdkcteam/native-webrtc)
2. Move to folder  <local_path>/native-webrtc/PC_Streamer
```
$cd <local_path>/native-webrtc/PC_Streamer
````
```
$sudo chmod +x webrtc_cam.sh
```
3. Execute the script webrtc_cam.sh to download webrtc code, trim the code to optimize the size, compile and install the server and client binaries
```
$./webrtc_cam.sh
```
4. Connect webcam, take a terminal and move to <local_path>/native-webrtc/PC_Streamer/webrtc-checkout/out/Default
```
$cd <local_path>/native-webrtc/PC_Streamer/webrtc-checkout/out/Default
```
5. Execute the binary peerconnection_server and confirm that the following print is displayed 
```
$. /peerconnection_server
 Server listening on port 8888
```
6. Take another terminal and move to <local_path>/native-webrtc/PC_Streamer/webrtc-checkout/out/Default and export library path first
```
$cd <local_path>/native-webrtc/PC_Streamer/webrtc-checkout/out/Default
$export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:’pwd’

```

7. Execute the binary peerconnection_client and provide the inputs [Server IP] and port number 8888 , when prompted
```
$./ peerconnection_client
```


## Instructions to set up Viewing side (gtk window application)
1. git clone (https://github.com/rdkcteam/native-webrtc)
2. Move to folder  <local_path>/native-webrtc/PC_Streamer
```
$cd <local_path>/native-webrtc/PC_Streamerr
````
```
$sudo chmod +x webrtc_cam.sh
```
3. Execute the script webrtc_browser.sh to download webrtc code, compile and install client binaries for viewing side with gtk window
```
$./webrtc_browser.sh
```
4. move to <local_path>/native-webrtc/PC_Streamer/webrtc-checkout/out/Default and export library path first
```
$cd <local_path>/native-webrtc/PC_Streamer/webrtc-checkout/out/Default
$export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:’pwd’

```
5. Execute the binary peerconnection_client and provide the inputs [Server IP] and port number 8888 , when prompted the gtk window
```
$./ peerconnection_client
```
6. Press connect button and double click on the peer name list down in the window.
7. Verify that video captured by the webcam display in the remote GTK window.


