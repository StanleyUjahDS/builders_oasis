import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/widgets/onboarding/welcome_page_widget.dart';
import '/widgets/onboarding/animated_dot_indicator.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';

class WelcomePage3 extends StatelessWidget {
  const WelcomePage3({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,

        // 🔝 APP BAR
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

        // 📱 BODY
        body: WelcomePageWidget(
          order: 3,
          title: "Ready to Begin",
          description: "You’re all set. Start exploring courses and take the"
              " first step toward mastering new skills.",
          imagePath: "assets/images/third_frame.png",

          //  BOTTOM ACTION
          bottomAction: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //  DOT INDICATORS (active = index 2)
              AnimatedDotIndicator(
                currentIndex: 2,
                length: 3,
              ),

              //  FINISH BUTTON
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                ),
                child:TextButton(onPressed:()=> context.go('/register'), child:
               Text("Get Started", style: TextStyle( color: Colors.white)))
              ),
            ],
          ),
        ),
      ),
    );
  }
}