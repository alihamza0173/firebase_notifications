import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen(
    this._message, {
    super.key,
  });

  final String? _message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$_message"),
        ],
      ),
    );
  }
}
