import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Welcome To The Chat Page'),
          ),
      ),
    );
  }
}