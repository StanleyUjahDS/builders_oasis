import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String category;
  final String instructor;
  final String image;
  final int durationHours;
  final double price;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.category,
    required this.instructor,
    required this.image,
    required this.durationHours,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.cardColor,

          border: Border(
            top: BorderSide(
              color: AppColors.red200.withValues(alpha: 0.6),
              width: 2,
            ),
            bottom: BorderSide(
              color: AppColors.red200.withValues(alpha: 0.6),
              width: 2,
            ),
            left: BorderSide.none,
            right: BorderSide.none,
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                image,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // INSTRUCTOR
                  Text(
                    instructor,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // CATEGORY
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // DURATION + PRICE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${durationHours}h"),
                      Text(
                        "\$${price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [

                    ],
                  ),
                  const SizedBox(height: 16),

                  // ADD TO CART
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onTap,
                        borderRadius: BorderRadius.circular(10),

                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),

                            border: Border(
                              top: BorderSide(
                                color: AppColors.red200.withValues(alpha: 0.6),
                                width: 1.5,
                              ),
                              bottom: BorderSide(
                                color: AppColors.red200.withValues(alpha: 0.6),
                                width: 1.5,
                              ),
                              left: BorderSide.none,
                              right: BorderSide.none,
                            ),
                          ),

                          child: const Text("Visit Course"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}