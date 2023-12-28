import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzify/helpers/answer_card.dart';
import 'package:quizzify/model/questions_model.dart';
import 'package:quizzify/utils/extentions.dart';

class ResponseScreen extends StatelessWidget {
  static const String routeName = '/response';
  const ResponseScreen(
      {super.key,
      required this.response,
      required this.question,
      required this.income});
  final QuestionModel question;
  final List<String> response;
  final String income;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        toolbarHeight: 40,
        backgroundColor: Colors.white,
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Text(
                "Your Response",
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            40.vs,
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return index == 2
                      ? AnswerCards(
                          question: "Your Annual Income", answer: response[index])
                      : AnswerCards(
                          question: question.schemas!.fields![index].schema!.label
                              .toString(),
                          answer: response[index]);
                },
              ),
            ),
          ],
        ));
  }
}
