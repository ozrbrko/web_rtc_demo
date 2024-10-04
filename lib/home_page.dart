import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_demo/home_controller.dart';
import 'package:web_rtc_demo/room_page.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Call App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await controller.createRoom();
                Get.to(() => RoomPage(action: 'create'));
              },
              child: Text("Create room"),
            ),
            SizedBox(height: 8),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              child: Row(
                children: [
                  Text("Join the following Room: "),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: controller.textEditingController,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                 controller.joinRoom();
              },
              child: Text("Join room"),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                controller.hangUp();
              },
              child: Text("Hangup"),
            ),
          ],
        ),
      ),
    );
  }
}