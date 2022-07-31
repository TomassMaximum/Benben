import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("通知提醒")),
      body: Column(
        children: [
          Switch(value: true, onChanged: (bool isOn) {})
        ],
      ),
    );
  }

}