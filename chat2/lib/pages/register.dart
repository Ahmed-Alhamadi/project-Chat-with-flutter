import 'package:chat2/constant.dart';
import 'package:chat2/helper/show_snack_bar.dart';
import 'package:chat2/pages/chatpage.dart';
import 'package:chat2/widget/custom_button.dart';
import 'package:chat2/widget/custom_textfild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String id = "register";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool Isloading = false;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Isloading,
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
                    "   Register",
                    style: TextStyle(fontSize: 22, color: Colors.white),
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
                  Isloading = true;
                  setState(() {});
                  if (formkey.currentState!.validate()) {
                    try {
                      await UserRegster();
                      Navigator.pushNamed(context, ChatPage.id,
                          arguments: email);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        ShowSnackBar(context, "weak password");
                      } else if (e.code == 'email-already-in-use') {
                        ShowSnackBar(context, "email-already-in-use");
                      }
                    } catch (e) {
                      print(e);
                    }
                    Isloading = false;
                    setState(() {});
                  } else {}
                },
                text: "Register",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "already have an acount",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "    Login",
                      style: TextStyle(color: Colors.white, fontSize: 18),
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

  Future<void> UserRegster() async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
