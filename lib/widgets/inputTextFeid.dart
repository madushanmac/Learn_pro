import 'package:flutter/material.dart';

class Inputtextfeid extends StatelessWidget {

  final String hintText;
  TextEditingController controller;
  bool obsecure;
   Inputtextfeid({super.key, required this.hintText , required this.controller,required this.obsecure});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
      child: TextField(
        controller: controller,
        obscureText: obsecure,
        decoration: InputDecoration(

          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
