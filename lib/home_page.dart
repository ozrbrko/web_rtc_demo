import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_demo/home_controller.dart';
import 'package:web_rtc_demo/asset_strings/images.dart';
import 'package:web_rtc_demo/room_page.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
                  SizedBox(height: 100),
                  Image.asset(MyImages.app_logo, width: 300, height: 100),
                  SizedBox(height: 100),
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
                  // Join Room Button
                  ElevatedButton(
                    onPressed: () {
                      controller.joinRoom();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Join Room',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
              
                  SizedBox(height: 20),
              
                  ElevatedButton(
                    onPressed: () async {
                      await controller.createRoom();
                      Get.to(() => RoomPage(action: 'create'));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
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