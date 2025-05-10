import 'package:flutter/material.dart';
import 'package:specimen_one/core/constants/app_theme.dart';

/// CategoryCard zeigt eine Kategorie mit Anzahl der Tests an
class CategoryCard extends StatelessWidget {
  final String title;
  final int count;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.count,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLightColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '$count Tests',
                  style: const TextStyle(
                    color: AppTheme.primaryDarkColor,
                    fontWeight: FontWeight.bold,
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
