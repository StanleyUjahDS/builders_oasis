import 'package:flutter/material.dart';

class CurrentLearningCard extends StatelessWidget {
  final String title;
  final String instructor;
  final String image;
  final double progress; // 0.0 → 1.0
  final VoidCallback onContinue;

  const CurrentLearningCard({
    super.key,
    required this.title,
    required this.instructor,
    required this.image,
    required this.progress,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).toInt();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(color: Colors.redAccent.withOpacity(0.3), width: 1.2),
          bottom: BorderSide(color: Colors.redAccent.withOpacity(0.3), width: 1.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),

      child: Row(
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          // DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  instructor,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 10),

                // PROGRESS BAR
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation(Colors.redAccent),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "$percent% completed",
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // BUTTON
          ElevatedButton(
            onPressed: onContinue,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}