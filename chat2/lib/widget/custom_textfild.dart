import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.hinttext,
      this.labeltext,
      this.onchanged,
      this.pass = false});
  String? hinttext;
  String? labeltext;
  bool? pass;
  Function(String)? onchanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: TextFormField(
        obscureText: pass!,
        validator: (data) {
          if (data!.isEmpty) {
            return "field is required";
          }
          return null;
        },
        onChanged: onchanged,
        decoration: InputDecoration(
            hintText: hinttext,
            labelText: labeltext,
            labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(),
            )),
      ),
    );
  }
}
