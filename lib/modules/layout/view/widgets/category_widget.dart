import 'package:flutter/material.dart';
import 'package:news/core/app_categories/app_categories.dart';

import '../../../../core/theme/app_colors.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.category,
    required this.isLeft,
  });

  final AppCategories category;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    final direction = isLeft ? TextDirection.ltr : TextDirection.rtl;

    return Container(
      height: 200,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        textDirection: direction,
        children: [
          Image.asset(
            category.image,
            width: 150,
            height: 200,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    category.name,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColors.black.withValues(alpha: .5),
                    borderRadius: BorderRadius.circular(84),
                  ),
                  child: Row(
                    textDirection: direction,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'View All',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.black,
                        ),
                        child: Icon(
                          isLeft ? Icons.arrow_forward_ios_rounded : Icons.arrow_back_ios_rounded,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

