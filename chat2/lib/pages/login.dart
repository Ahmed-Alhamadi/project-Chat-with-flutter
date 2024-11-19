import 'package:chat2/constant.dart';
import 'package:chat2/helper/show_snack_bar.dart';
import 'package:chat2/pages/chatpage.dart';
import 'package:chat2/pages/register.dart';
import 'package:chat2/widget/custom_button.dart';
import 'package:chat2/widget/custom_textfild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = "loginpage";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

GlobalKey<FormState> formkey = GlobalKey();

class _LoginPageState extends State<LoginPage> {
  bool load = false;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: load,
      child: Scaffold(
        backgroundColor: kPriamarybackground,
        body: Form(
          key: formkey,
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                "assets/ph.png",
                height: 150,
              ),
              const Center(
                child: Text(
                  "Scholar Chat",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
              const Row(
                children: [
                  Text(
                    "   Login",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                onchanged: (data) {
                  email = data;
                },
                hinttext: "Email",
                labeltext: "Enter email",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                onchanged: (data) {
                  password = data;
                },
                pass: true,
                hinttext: "Password",
                labeltext: "Enter Password",
              ),
              CustomButton(
                ontap: () async {
                  load = true;
                  setState(() {});
                  if (formkey.currentState!.validate()) {
                    try {
                      await loginUser();
                      Navigator.pushNamed(context, ChatPage.id,
                          arguments: email);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        ShowSnackBar(context, "'No user found for that email");
                      } else if (e.code == 'wrong-password') {
                        ShowSnackBar(
                            context, 'Wrong password provided for that user.');
                      }
                    } catch (e) {
                      print(e);
                    }

                    load = false;
                    setState(() {});
                  } else {}
                },
                text: "login",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "dont have an acount",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                    child: const Text(
                      "     Register",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
