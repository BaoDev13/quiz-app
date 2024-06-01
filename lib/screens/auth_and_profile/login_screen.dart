import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quizz_app/configs/configs.dart';
import 'package:quizz_app/controllers/auth_controller.dart';
import 'package:quizz_app/widgets/widgets.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: Container(
          constraints: const BoxConstraints(maxWidth: kTabletChangePoint),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/icons8-quizizz-128.png'),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Text(
                  'Welcome to Quizz App!\n\n'
                  'Unlock your potential with Quizz App, where learning meets fun. Dive into a world of knowledge and challenge yourself with our diverse quizzes. Whether you\'re here to learn something new or test your existing skills, we\'re excited to have you on board. Log in to get started and track your progress!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kOnSurfaceTextColor, fontWeight: FontWeight.bold),
                ),
              ),
              MainButton(
                onTap: () {
                  controller.siginInWithGoogle();
                },
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        child: SvgPicture.asset(
                          'assets/icons/google.svg',
                        )),
                    Center(
                      child: Text(
                        'Sign in  with google',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
