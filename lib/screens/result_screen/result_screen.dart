import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz_codary_v1/controllers/quiz_controller.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);
  static const routeName = '/result_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/quiz.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        Center(
          child: GetBuilder<QuizController>(
            init: Get.find<QuizController>(),
            builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  controller.name,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Quiz Score',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Your Score: ${Get.find<QuizController>().scoreResult.round()} out of ${Get.find<QuizController>().countOfQuestion}',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.green,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(onPressed: () => controller.startAgain(), child: const Text('Play Again'),),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
