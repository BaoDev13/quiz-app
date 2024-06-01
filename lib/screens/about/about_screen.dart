import 'package:flutter/material.dart';
import 'package:quizz_app/configs/configs.dart';
import 'package:quizz_app/widgets/widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  static const String routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: BackgroundDecoration(
        showGradient: true,
        child: Padding(
          padding: UIParameters.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Quiz App',
                style: kHeaderTS.copyWith(color: kOnSurfaceTextColor),
              ),
              const SizedBox(height: 20),
              const Text(
                "Welcome to Quiz App! Our application is designed to make learning fun and engaging through interactive quizzes. Whether you're a student looking to reinforce your knowledge, a professional seeking to expand your skills, or just someone who loves a good challenge, Quiz App has something for everyone.",
                style: TextStyle(
                  color: kOnSurfaceTextColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Our mission is to provide a platform that promotes continuous learning and intellectual growth. We believe that learning should be enjoyable and accessible to everyone, and our app is built with this philosophy in mind.",
                style: TextStyle(
                  color: kOnSurfaceTextColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Thank you for choosing Quiz App! We are constantly working on new features and improvements, so stay tuned for updates. If you have any feedback or suggestions, feel free to contact us. Happy quizzing!",
                style: TextStyle(
                  color: kOnSurfaceTextColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
