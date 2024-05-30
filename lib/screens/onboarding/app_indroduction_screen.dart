import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizz_app/configs/themes/app_colors.dart';
import 'package:quizz_app/screens/home/home_screen.dart';
import 'package:quizz_app/widgets/common/circle_button.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);
  static const String routeName = '/introduction';
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Get.offAndToNamed(HomeScreen.routeName);
    });
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: mainGradient(context)),
      ),
    );
  }
}
