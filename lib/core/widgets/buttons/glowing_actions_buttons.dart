import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/themes/theme.dart';

class GlowingActionButton extends StatelessWidget {
  const GlowingActionButton({
    required this.color,
    required this.icon,
    required this.onPressed,
    this.size = 54,
    super.key,
  });

  final Color color;
  final IconData icon;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          spreadRadius: 8,
          blurRadius: 24,
        ),
      ],
    ),
    child: ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          splashColor: AppColors.cardLight,
          onTap: onPressed,
          child: SizedBox(
            width: size,
            height: size,
            child: Icon(icon, size: 26, color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
