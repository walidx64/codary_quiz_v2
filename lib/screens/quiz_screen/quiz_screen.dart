
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_codary_v1/controllers/quiz_controller.dart';
import 'package:quiz_codary_v1/widgets/question_card.dart';


class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);
  static const routeName = '/quiz_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/quiz.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          SafeArea(
            child: GetBuilder<QuizController>(
              init: QuizController(),
              builder: (controller) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'Question ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.black),
                              children: [
                                TextSpan(
                                    text: controller.numberOfQuestion
                                        .round()
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(color: Colors.green)),
                                TextSpan(
                                    text: '/',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(color: Colors.black)),
                                TextSpan(
                                    text: controller.countOfQuestion.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(color: Colors.black)),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    controller.name,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => QuestionCard(
                        questionModel: controller.questionsList[index],
                      ),
                      controller: controller.pageController,
                      itemCount: controller.questionsList.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(onPressed: () => controller.nextQuestion(), child: const Text('Next Question'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
