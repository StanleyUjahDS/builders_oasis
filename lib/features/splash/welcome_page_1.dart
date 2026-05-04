import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/widgets/onboarding/welcome_page_widget.dart';
import '/widgets/onboarding/animated_dot_indicator.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';

class WelcomePage1 extends StatelessWidget {
  const WelcomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,

        appBar: AppBar(
          automaticallyImplyLeading: false,

          actions: [
            TextButton(
              onPressed: () => context.go('/register'),
              child: const Text("Skip"),
            ),
          ],
        ),

        body: WelcomePageWidget(
          order: 1,

          title: "Welcome to Builders Oasis",

          description:
          "Start your learning journey with structured courses "
              "designed to help you grow step by step.",

          imagePath: "assets/images/first_frame.png",

          bottomAction: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              AnimatedDotIndicator(
                currentIndex: 0,
                length: 3,
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                ),

                child: IconButton(
                  onPressed: () => context.push('/welcome_two'),

                  icon: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}