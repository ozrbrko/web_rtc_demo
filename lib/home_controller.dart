// lib/home_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:web_rtc_demo/room_page.dart';
import 'package:web_rtc_demo/signaling.dart';
import 'package:web_rtc_demo/home_page.dart';

class HomeController extends GetxController {
  Signaling signaling = Signaling();
  RTCVideoRenderer localRenderer = RTCVideoRenderer();
  RTCVideoRenderer remoteRenderer = RTCVideoRenderer();
  var roomId = ''.obs;
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  void onInit() {
    super.onInit();
    initRenderers();
    signaling.onAddRemoteStream = ((stream) {
      remoteRenderer.srcObject = stream;
      update();
    });
  }

  Future<void> initRenderers() async {
    await localRenderer.initialize();
    await remoteRenderer.initialize();
  }

  @override
  void onClose() {
    localRenderer.dispose();
    remoteRenderer.dispose();
    super.onClose();
  }

  Future<void> createRoom() async {
    await signaling.openUserMedia(localRenderer, remoteRenderer);
    roomId.value = await signaling.createRoom(remoteRenderer) ?? '';
    // textEditingController.text = roomId.value;
  }

  Future<bool> validateRoomId(String roomId) async {
    if(roomId.isNotEmpty) {
      DocumentSnapshot roomSnapshot = await FirebaseFirestore.instance.collection('rooms').doc(roomId).get();
      return roomSnapshot.exists;
    } else {
      return false;
    }
  }

  void joinRoom() async {
    String roomId = textEditingController.text.trim();
    bool isValid = await validateRoomId(roomId);
    if (isValid) {
      await signaling.openUserMedia(localRenderer, remoteRenderer);
      signaling.joinRoom(roomId, remoteRenderer);
      Get.to(() => RoomPage(action: 'join'));
    } else {
      Get.snackbar('Error', 'Invalid Room ID',backgroundColor:  Colors.white);
    }
  }

  void hangUp() {
    signaling.hangUp(localRenderer);
    Get.offAll(() => HomePage());
  }
}