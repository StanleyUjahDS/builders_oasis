import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';
class WelcomePageWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final int order;
  final Widget? bottomAction;

  const WelcomePageWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.order,
    this.bottomAction,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 150,
                        backgroundColor: AppColors.red100,
                      ),
                      Image.asset(
                        imagePath,
                        height: 400,
                        width: 400,

                        fit: BoxFit.contain,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  //  TITLE
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: textTheme.headlineLarge,
                  ),

                  const SizedBox(height: 12),

                  //  DESCRIPTION
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          //  BOTTOM FIXED ACTION
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 20,
              top: 10,
            ),
            child: bottomAction ?? const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}