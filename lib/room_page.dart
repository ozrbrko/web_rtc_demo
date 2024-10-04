import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:web_rtc_demo/home_controller.dart';

class RoomPage extends StatelessWidget {
  final String action;
  final HomeController controller = Get.put(HomeController());

  RoomPage({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Call App - $action"),
        actions: [
          if (action == 'create')
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Room ID: ${controller.roomId.value}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          ObxValue<Rx<RTCVideoRenderer>>(
                (data) => Center(
              child: data.value.srcObject != null
                  ? RTCVideoView(data.value)
                  : const Text("Waiting for remote user..."),
            ),
            controller.remoteRenderer.obs,
          ),
          ObxValue<Rx<RTCVideoRenderer>>(
                (data) => Positioned(
              bottom: 20,
              right: 20,
              width: 150,
              height: 200,
              child: data.value.srcObject != null
                  ? RTCVideoView(data.value, mirror: true)
                  : Container(
                color: Colors.black,
                child: const Center(
                  child: Text(
                    "Local video",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            controller.localRenderer.obs,
          )
        ],
      ),
    );
  }
}