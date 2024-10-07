import 'package:faconnection/asset_strings/images.dart';
import 'package:faconnection/extensions/num_extensions.dart';
import 'package:faconnection/extensions/widget_extensions.dart';
import 'package:faconnection/home/home_controller.dart';
import 'package:faconnection/rooms/room_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MyImages.homeBack),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                100.height,
                Image.asset(MyImages.app_logo).heighted(100).w(300),
                120.height,
                RoomIdField(),
                20.height,
                joinRoomButton(),
                20.height,
                createRoomButton(),
              ],
            ),
          ).paddingOnly(left: 32, right: 32),
        ),
      ),
    );
  }


  TextFormField RoomIdField() {
    return TextFormField(
      controller: controller.textEditingController,
      decoration: InputDecoration(
        hintText: 'Enter Room ID',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
  ElevatedButton joinRoomButton() {
    return ElevatedButton(
      onPressed: () {
        controller.joinRoom();
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Join Room',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
  ElevatedButton createRoomButton() {
    return ElevatedButton(
                  onPressed: () async {
                    await controller.createRoom();
                    Get.to(() => RoomPage(action: 'create'));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Create Room',
                    style: TextStyle(fontSize: 18),
                  ),
                );
  }

}