import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/widgets/onboarding/welcome_page_widget.dart';
import '/widgets/onboarding/animated_dot_indicator.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';

class WelcomePage1 extends StatelessWidget {
  const WelcomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,

        //  APP BAR (SKIP ONLY)
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,

          actions: [
            TextButton(
              onPressed: () => context.go('/register'),
              child: Text(
                "Skip",
              ),
            ),
          ],
        ),

        //  BODY
        body: WelcomePageWidget(
          order: 1,
          title: "Welcome to Builders Oasis",
          description: "Start your learning journey with structured courses"
              " designed to help you grow step by step.",
          imagePath: "assets/images/first_frame.png",

          //  BOTTOM ACTION
          bottomAction: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //  ANIMATED DOTS
              AnimatedDotIndicator(
                currentIndex: 0,
                length: 3,
              ),

              //  NEXT BUTTON (ROUNDED PLAY ICON)
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