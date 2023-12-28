import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    required this.hinttext,
    required this.isPassword,
    this.isCaptcha = false,
    required this.textEditingController
  });
  final String hinttext;
  final bool isPassword;
  final bool isCaptcha;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: TextInputType.number,
      cursorColor: Colors.grey,
      obscureText: isPassword ? true : false,
      decoration: InputDecoration(
        suffixText: isCaptcha ? '12345' : "",
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.deepOrangeAccent),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrangeAccent),
        ),
        hintText: hinttext,
        hintStyle: GoogleFonts.roboto(
          color: Colors.grey,
          fontWeight: FontWeight.w300,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
