import 'package:chat2/constant.dart';
import 'package:chat2/models/message.dart';
import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

class CustomChat extends StatelessWidget {
  CustomChat({super.key, required this.message});

  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding:
            const EdgeInsets.only(left: 10, top: 15, right: 20, bottom: 15),
        decoration: const BoxDecoration(
          color: kPriamarybackground,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(30)),
        ),
        child: Text(message.message,
            style: const TextStyle(color: Color(0xFFFBECED), fontSize: 20)),
      ),
    );
  }
}

class CustomChatFrom extends StatelessWidget {
  CustomChatFrom({super.key, required this.message});
  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding:
            const EdgeInsets.only(left: 10, top: 15, right: 20, bottom: 15),
        decoration: const BoxDecoration(
          color: Color(0xFF766DFF),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(30)),
        ),
        child: Text(message.message,
            style: const TextStyle(color: Color(0xFFFBECED), fontSize: 20)),
      ),
    );
  }
}
