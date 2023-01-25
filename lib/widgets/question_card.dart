import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz_codary_v1/controllers/quiz_controller.dart';
import 'package:quiz_codary_v1/models/question_model.dart';

import 'answer_option.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel questionModel;

  const QuestionCard({
    Key? key,
    required this.questionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          height: 400,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  questionModel.question,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 20,),
                ...List.generate(
                    questionModel.options.length,
                    (index) => Column(
                          children: [
                            AnswerOption(
                                questionId: questionModel.id,
                                text: questionModel.options[index],
                                index: index,
                                onPressed: () => Get.find<QuizController>()
                                    .checkAnswer(questionModel, index),),
                            const SizedBox(
                              height: 12,
                            )
                          ],
                        ),),
              ],
            ),
          ),),
    );
  }
}
