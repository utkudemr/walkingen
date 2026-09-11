import 'package:flutter/material.dart';

class WalkingActionButton extends StatelessWidget {
  const WalkingActionButton({
    super.key,
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.child,
    this.filled = false,
    this.width,
    this.height = 128,
    this.borderRadius = 40,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback? onPressed;
  final Widget? child;
  final bool filled;
  final double? width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(width ?? 0, height)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
    final button = SizedBox(
      width: width,
      height: height,
      child: filled
          ? FilledButton(
              onPressed: onPressed,
              style: style,
              child: child ?? Icon(icon, size: 42),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: style,
              child: child ?? Icon(icon, size: 42),
            ),
    );
    return Tooltip(
      message: tooltip,
      child: Semantics(button: true, label: tooltip, child: button),
    );
  }
}
