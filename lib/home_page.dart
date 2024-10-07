import 'package:faconnection/asset_strings/images.dart';
import 'package:faconnection/home_controller.dart';
import 'package:faconnection/room_page.dart';
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
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Image.asset(MyImages.app_logo, width: 300, height: 100),
                  const SizedBox(height: 100),
                  const SizedBox(height: 20),
                  // TextFormField with border radius
                  TextFormField(
                    controller: controller.textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Enter Room ID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Join Room Button
                  ElevatedButton(
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
                  ),
              
                  const SizedBox(height: 20),
              
                  ElevatedButton(
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}