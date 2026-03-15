import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/themes/theme.dart';

class IconBackgroundButtons extends StatelessWidget {
  const IconBackgroundButtons({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Theme.of(context).cardColor,
    borderRadius: BorderRadius.circular(6),
    child: InkWell(
      borderRadius: BorderRadius.circular(6),
      splashColor: AppColors.secondary,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 22),
      ),
    ),
  );
}

class IconBorderButtons extends StatelessWidget {
  const IconBorderButtons({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    borderRadius: BorderRadius.circular(6),
    splashColor: AppColors.secondary,
    onTap: onTap,
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 2, color: Theme.of(context).cardColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 22),
      ),
    ),
  );
}
