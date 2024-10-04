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
      body: Stack(
        children: [
          // Remote user video (Tam ekran)
          ObxValue<Rx<RTCVideoRenderer>>(
                (data) => Container(
              width: double.infinity,
              height: double.infinity,
              child: data.value.srcObject != null
                  ? RTCVideoView(
                data.value,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover, // Tam ekran için
              )
                  : const Center(
                child: Text(
                  "Waiting for remote user...",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            controller.remoteRenderer.obs,
          ),
          // Local user video (Küçük pencere köşede)
          ObxValue<Rx<RTCVideoRenderer>>(
                (data) => Positioned(
              bottom: 20,
              right: 20,
              width: 150,
              height: 200,
              child: data.value.srcObject != null
                  ? Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2), // Küçük video için kenarlık
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RTCVideoView(
                  data.value,
                  mirror: true,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                ),
              )
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
          ),
          // Room ID (Sağ üstte, radiuslu)
          Positioned(
            top: 20,
            right: 20,
            child: Obx(
                  () => Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Room ID: ${controller.roomId.value}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}