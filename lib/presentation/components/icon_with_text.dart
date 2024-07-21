import 'package:flutter/material.dart';
import 'package:security_police_app/presentation/themes/app_theme.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const IconWithText({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: color,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class IconTextButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const IconTextButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: AppTheme.foregroundColor,
        foregroundColor: AppTheme.textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: AppTheme.borderColor),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      ),
      icon: Icon(icon, color: AppTheme.textColor),
      label: Text(text, style: const TextStyle(color: AppTheme.textColor)),
      onPressed: onPressed,
    );
  }
}
