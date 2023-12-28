import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzify/model/questions_model.dart';
import 'package:quizzify/utils/extentions.dart';

class QuestionWidget extends StatefulWidget {
   QuestionWidget({
    super.key,
    required this.options,
    required this.title,
    required this.controller,
    required this.question,
  });
  final String title;
  final List<Options>? options;
   List<String> controller;
   List<String> question;
  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  Options? _selectedOptions;
  
  Color getColor(Options option) {
    return _selectedOptions == option ? Colors.deepOrangeAccent : Colors.grey;
  }
  

  @override
  Widget build(BuildContext context) {
    
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Text(
          widget.title,
          style: GoogleFonts.lato(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black54),
        ),
      ),
      20.vs,
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...widget.options!.map((option) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: getColor(option)),
                ),
                margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                width: double.infinity,
                height: 55.h,
                child: RadioListTile<Options>(
                    activeColor: Colors.deepOrangeAccent,
                    title: Text(
                      option.value.toString(),
                      style: GoogleFonts.lato(
                          color: getColor(option), fontSize: 14.sp),
                    ),
                    groupValue: _selectedOptions,
                    value: option,
                    onChanged: (value) {
                      setState(() {
                        _selectedOptions = value;
                        print(_selectedOptions!.value);
                        widget.controller.add(_selectedOptions!.value.toString());
                        
                      });
                    }),
              )),
        ],
      )
    ]);
  }
}
