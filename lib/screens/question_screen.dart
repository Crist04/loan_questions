import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizzify/helpers/custom_tabs.dart';
import 'package:quizzify/helpers/my_textfield.dart';
import 'package:quizzify/model/questions_model.dart';
import 'package:quizzify/screens/all_response_screen.dart';
import 'package:quizzify/screens/widgets/questions_widget.dart';
import 'package:quizzify/utils/api.dart';
import 'package:quizzify/utils/extentions.dart';

class QuestionScreen extends StatefulWidget {
  static const String routeName = '/splash';
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<QuestionScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int index = 0;
  List<String> questions = [];
  List<String> answers = [];
  TextEditingController text = TextEditingController();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      readQuestions();
      _tabController = TabController(
        length: 5,
        initialIndex: index,
        vsync: this,
      );
    });
    super.initState();
  }

  readQuestions() async {
    await context.read<QuestionsNotifier>().getQuestions(false);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<QuestionsNotifier>().questions;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.white,
      ),
      body: Consumer<QuestionsNotifier>(builder: (context, value, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 120.vs,
            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Text(
                value.questions.title.toString(),
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.h, left: 30.w),
              child: CustomTabPageSelector(
                controller: _tabController,
                itemCount: value.questions.schemas!.fields!.length,
                currentIndex: index,
                selectedColor: Color.fromARGB(255, 90, 243, 210),
                unselectedColor: Color.fromARGB(255, 90, 243, 210),
                indicatorSize: 59,
              ),
            ),
            20.vs,
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: List.generate(
                  value.questions.schemas!.fields!.length,
                  (index) {
                    questions.add(value
                        .questions.schemas!.fields![index].schema!.label
                        .toString());
                    return value.questions.schemas!.fields![index].type ==
                            "Section"
                        ? value.questions.schemas!.fields![index].schema!
                                    .name ==
                                "Section1"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.w),
                                    child: Text(
                                      value.questions.schemas!.fields![index]
                                          .schema!.label
                                          .toString(),
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black54),
                                    ),
                                  ),
                                  30.vs,
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.w),
                                    height: 50.sp,
                                    width: 300.w,
                                    child: MyTextField(
                                        textEditingController: text,
                                        hinttext: "Your Family Income",
                                        isPassword: false),
                                  ),
                                  10.vs,
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.w),
                                    child: Text(
                                      value.questions.schemas!.fields![index]
                                          .schema!.fieldss![1].schema!.name
                                          .toString(),
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.black54),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.w),
                                    child: Text(
                                      value.questions.schemas!.fields![index]
                                          .schema!.label
                                          .toString(),
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black54),
                                    ),
                                  ),
                                  20.vs,
                                  Container(
                                    height: height * 0.56,
                                    child: ListView.builder(
                                      itemCount: value
                                          .questions
                                          .schemas!
                                          .fields![index]
                                          .schema!
                                          .fieldss!
                                          .length,
                                      itemBuilder: (context, i) {
                                        return QuestionWidget(
                                          question: questions,
                                          controller: answers,
                                          title: value
                                              .questions
                                              .schemas!
                                              .fields![index]
                                              .schema!
                                              .fieldss![i]
                                              .schema!
                                              .label
                                              .toString(),
                                          options: value
                                              .questions
                                              .schemas!
                                              .fields![index]
                                              .schema!
                                              .fieldss![i]
                                              .schema!
                                              .optionss,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                        : QuestionWidget(
                            question: questions,
                            controller: answers,
                            title: value
                                .questions.schemas!.fields![index].schema!.label
                                .toString(),
                            options: value.questions.schemas!.fields![index]
                                .schema!.optionss,
                          );
                  },
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: index != 4
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                20.hs,
                InkWell(
                  onTap: () {
                    setState(() {
                      index -= 1;
                      _tabController.animateTo(index);
                    });
                  },
                  child: Container(
                      width: height > 800
                          ? 110.w
                          : height > 700
                              ? 100.w
                              : 90.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          width: 1.5.w,
                          color: Colors.white,
                        ),
                      ),
                      child: Row(
                        children: [
                          14.hs,
                          const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.blueGrey,
                            size: 23,
                          ),
                          const Padding(
                              padding: EdgeInsets.zero,
                              child: Text(
                                "Back",
                                style: TextStyle(fontSize: 16),
                              )),
                        ],
                      )),
                ),
                const Expanded(child: SizedBox()),
                FloatingActionButton(
                  backgroundColor: Colors.deepOrangeAccent,
                  shape: const CircleBorder(),
                  onPressed: () {
                    (index != provider.schemas!.fields!.length)
                        ? index++
                        : index = 0;
                    _tabController.animateTo(index);
                    FocusScope.of(context).unfocus();

                    print(answers);
                    print(questions);
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ],
            )
          // Get Started Button
          : InkWell(
              onTap: () {
                setState(() {
                  index = 0;
                  _tabController.animateTo(index);
                });
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    answers.insert(2, text.text);
                    questions.removeAt(2);
                    return ResponseScreen(
                      response: answers,
                      question: context.read<QuestionsNotifier>().questions,
                      income: text.text,
                    );
                  },
                ));
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50.h,
                margin: EdgeInsets.only(left: 40.w, right: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  color: Colors.deepOrangeAccent,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(74, 0, 0, 0),
                      offset: const Offset(0, 6),
                      blurRadius: 10.r,
                    ),
                  ],
                ),
                child: Center(
                    child: Text(
                  'Finish',
                  style: GoogleFonts.lato(color: Colors.white),
                )),
              ),
            ),
    );
  }
}
