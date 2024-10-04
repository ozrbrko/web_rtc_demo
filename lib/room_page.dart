import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:web_rtc_demo/home_controller.dart';

class RoomPage extends StatelessWidget {
  final String action;
  final HomeController controller = Get.put(HomeController());

  RoomPage({super.key, required this.action});

  final Rx<Offset> localVideoPosition = Offset(20, 20).obs;
  final RxBool isLocalVideoLarge = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Remote user video
          ObxValue<Rx<RTCVideoRenderer>>(
                (data) => isLocalVideoLarge.value
                ? Positioned(
              left: localVideoPosition.value.dx,
              top: localVideoPosition.value.dy,
              child: Draggable(
                feedback: Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: data.value.srcObject != null
                      ? RTCVideoView(
                    data.value,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  )
                      : Container(
                    color: Colors.black,
                    child: const Center(
                      child: Text(
                        "Remote video",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                childWhenDragging: Container(),
                onDragEnd: (details) {
                  localVideoPosition.value = details.offset;
                },
                child: GestureDetector(
                  onTap: () {
                    isLocalVideoLarge.value = !isLocalVideoLarge.value;
                  },
                  child: Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: data.value.srcObject != null
                        ? RTCVideoView(
                      data.value,
                      objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    )
                        : Container(
                      color: Colors.black,
                      child: const Center(
                        child: Text(
                          "Remote video",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
                : Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  isLocalVideoLarge.value = !isLocalVideoLarge.value;
                },
                child: data.value.srcObject != null
                    ? RTCVideoView(
                  data.value,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                )
                    : const Center(
                  child: Text(
                    "Waiting for remote user...",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            controller.remoteRenderer.obs,
          ),
          // Local user video
          Obx(
                () => isLocalVideoLarge.value
                ? Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  isLocalVideoLarge.value = !isLocalVideoLarge.value;
                },
                child: ObxValue<Rx<RTCVideoRenderer>>(
                      (data) => data.value.srcObject != null
                      ? RTCVideoView(
                    data.value,
                    mirror: true,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
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
                  controller.localRenderer.obs,
                ),
              ),
            )
                : Positioned(
              left: localVideoPosition.value.dx,
              top: localVideoPosition.value.dy,
              child: Draggable(
                feedback: ObxValue<Rx<RTCVideoRenderer>>(
                      (data) => Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: data.value.srcObject != null
                        ? RTCVideoView(
                      data.value,
                      mirror: true,
                      objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
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
                childWhenDragging: Container(),
                onDragEnd: (details) {
                  localVideoPosition.value = details.offset;
                },
                child: GestureDetector(
                  onTap: () {
                    isLocalVideoLarge.value = !isLocalVideoLarge.value;
                  },
                  child: ObxValue<Rx<RTCVideoRenderer>>(
                        (data) => Container(
                      width: 150,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: data.value.srcObject != null
                          ? RTCVideoView(
                        data.value,
                        mirror: true,
                        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
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
                ),
              ),
            ),
          ),
          // Room ID
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