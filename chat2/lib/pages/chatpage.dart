import 'package:chat2/constant.dart';
import 'package:chat2/models/message.dart';
import 'package:chat2/widget/custom_chat.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  static String id = "ChatPage";

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController controller = TextEditingController();
  ScrollController controllerr = ScrollController();

  @override
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollections);

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreateAt, descending: true).snapshots(),
        builder: (context, Snapshat) {
          if (Snapshat.hasData) {
            List<Message> messageList = [];
            for (int i = 0; i < Snapshat.data!.docs.length; i++) {
              messageList.add(Message.fromJson(Snapshat.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPriamarybackground,
                title: const Text("Chat"),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: controllerr,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return messageList[index].id == email
                              ? CustomChat(
                                  message: messageList[index],
                                )
                              : CustomChatFrom(message: messageList[index]);
                        }),
                  ),
                  TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        "message": data,
                        kCreateAt: DateTime.now(),
                        "id": email
                      });
                      controller.clear();
                      controllerr.animateTo(0,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn);
                    },
                    decoration: InputDecoration(
                        hintText: "Send Message",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: kPriamarybackground, width: 5),
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFF4C4CEF)),
                            borderRadius: BorderRadius.circular(33)),
                        suffixIcon: const Icon(
                          Icons.send,
                          color: Color(0xFF0E0EE4),
                          size: 28,
                        )),
                  )
                ],
              ),
            );
          } else {
            return const Text("lodeing...");
          }
        });
  }
}
