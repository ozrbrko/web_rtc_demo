import 'package:faconnection/extensions/widget_extensions.dart';
import 'package:faconnection/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';

class RoomPage extends StatelessWidget {
  final String action;
  final HomeController controller = Get.put(HomeController());

  RoomPage({super.key, required this.action});

  final Rx<Offset> localVideoPosition = const Offset(20, 20).obs;
  final RxBool isLocalVideoLarge = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          remoteVideo(),
          localVideo(),
          roomId(),
          hangUpButton(),
        ],
      ),
    );
  }

  ObxValue<Rx<RTCVideoRenderer>> remoteVideo() {
    return ObxValue<Rx<RTCVideoRenderer>>(
              (data) => isLocalVideoLarge.value
              ? Positioned(
            left: localVideoPosition.value.dx,
            top: localVideoPosition.value.dy,
            child: Draggable(
              feedback: Container(
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
              ).heighted(200).w(150),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                localVideoPosition.value = details.offset;
              },
              child: GestureDetector(
                onTap: () {
                  isLocalVideoLarge.value = !isLocalVideoLarge.value;
                },
                child: Container(
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
                ).heighted(200).w(150),
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
        );
  }
  Obx localVideo() {
    return Obx(
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
            ).heighted(200).w(150),
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
              ).heighted(200).w(150),
              controller.localRenderer.obs,
            ),
          ),
        ),
      ),
    );
  }
  Positioned roomId() {
    return Positioned(
      top: 20,
      right: 20,
      child: Obx(
            () => Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Room ID: ${controller.roomId.value}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
  Positioned hangUpButton() {
    return Positioned(
      bottom: 20,
      left: Get.width / 2 - 32,
      child: SizedBox(
        width: 65,
        height: 65,
        child: FloatingActionButton(
          onPressed: () {controller.hangUp();},
          backgroundColor: Colors.red,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.call_end,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
    );
  }
}