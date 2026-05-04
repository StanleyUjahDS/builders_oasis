import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

class CourseDetailCard extends StatelessWidget {
  final String title;
  final String category;
  final String instructor;
  final String image;
  final int durationHours;
  final double price;

  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const CourseDetailCard({
    super.key,
    required this.title,
    required this.category,
    required this.instructor,
    required this.image,
    required this.durationHours,
    required this.price,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),

      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.cardColor,

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

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues( alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                image,
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // INSTRUCTOR
                  Text(
                    instructor,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 2),

                  // CATEGORY
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // INFO ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${durationHours}h",
                        style: const TextStyle(fontSize: 13),
                      ),
                      Text(
                        "\$${price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ADD TO CART BUTTON (CUSTOM BORDER STYLE)
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),

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

                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: onAddToCart,
                          child: const Center(
                            child: Text(
                              "Add to Cart",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
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