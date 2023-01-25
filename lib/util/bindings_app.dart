import 'package:get/get.dart';
import 'package:quiz_codary_v1/controllers/quiz_controller.dart';

class BilndingsApp implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuizController());
  }
}
// QuizController class as a dependency for the app.
