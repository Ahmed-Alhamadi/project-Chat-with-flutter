import 'package:chat2/firebase_options.dart';
import 'package:chat2/pages/chatpage.dart';
import 'package:chat2/pages/login.dart';
import 'package:chat2/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "LoginPage": (context) => const LoginPage(),
        RegisterPage.id: (context) => const RegisterPage(),
        ChatPage.id: (context) => const ChatPage(),
      },
      initialRoute: "LoginPage",
    );
  }
}
