import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz_codary_v1/controllers/quiz_controller.dart';
import 'package:quiz_codary_v1/screens/quiz_screen/quiz_screen.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const routeName = '/welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _nameController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey();

  void _submit(context) {
    FocusScope.of(context).unfocus();
    if (!_formkey.currentState!.validate()) return;
    _formkey.currentState!.save();
    Get.offAndToNamed(QuizScreen.routeName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
              'Codary Quiz App',
              style: TextStyle(color: Colors.white)
          ),
        ),
      ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/quiz.jpg'),
                fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Text(
                      'Please Enter your Name',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 10,),

                    //Enter the User name
                    Form(
                      key: _formkey,
                      child: GetBuilder<QuizController>(
                        init: Get.find<QuizController>(),
                        builder: (controller) => TextFormField(
                          controller: _nameController,
                          style: const TextStyle(color: Colors.green),
                          decoration: const InputDecoration(
                              // labelText: 'Your Cool Name 😎',
                              // labelStyle: TextStyle(color: Colors.black),
                            hintText: 'Your Cool Name 😎',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0),
                                      ),
                              ),
                          ),
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return 'Name should not be empty';
                            }
                            else if (val!.length > 10) {
                              return 'Name should not be more than 10 letters';
                            }
                            else {
                              return null;
                            }
                          },
                          onSaved: (String? val) {
                            controller.name = val!.trim().toUpperCase();
                          },
                          onFieldSubmitted: (_) => _submit(context),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(onPressed: () => _submit(context), child: const Text('Start Quiz'),),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }
}
