import 'package:flutter/material.dart';

class AnimatedDotIndicator extends StatelessWidget {
  final int currentIndex;
  final int length;

  const AnimatedDotIndicator({
    super.key,
    required this.currentIndex,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(length, (index) {
        final isActive = index == currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 12 : 10,
          height: isActive ? 12 : 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? Colors.red
                : Colors.transparent,
            border: Border.all(
              color: Colors.red,
              width: 1.5,
            ),
          ),
        );
      }),
    );
  }
}