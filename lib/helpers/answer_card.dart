import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerCards extends StatelessWidget {
  const AnswerCards({super.key,required this.question,required this.answer});
  final String question;
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                question,
                style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0),
              ),
              const SizedBox(height: 5.0),
              Text(
                answer,
                style: GoogleFonts.lato(
                    color:  Colors.deepOrangeAccent,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
