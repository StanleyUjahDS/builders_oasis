import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/widgets/onboarding/welcome_page_widget.dart';
import '/widgets/onboarding/animated_dot_indicator.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';

class WelcomePage2 extends StatelessWidget {
  const WelcomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
              onPressed: () => context.go('/home'),
              child: Text(
                "Skip",
                style: TextStyle(color: colorScheme.onSurface),
              ),
            ),
          ],
        ),

        // 📱 BODY
        body: WelcomePageWidget(
          order: 2,
          title: "Learn with Structure",
          description: "Access well-organized courses, track your progress,"
              " and build skills at your own pace.",
          imagePath: "assets/images/second_frame.png",

          //  BOTTOM ACTION
          bottomAction: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //  DOT INDICATORS (active = index 1)
              AnimatedDotIndicator(
                currentIndex: 1,
                length: 3,
              ),

              // ️ NEXT BUTTON
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  onPressed: () => context.push('/welcome_three'),
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