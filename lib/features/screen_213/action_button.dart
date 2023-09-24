import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:mvp_taplan/models/models.dart';

class PostcardButton extends StatelessWidget {
  final bool isPressed;
  final VoidCallback? onTap;
  final String text;
  final bool hasStar;
  final double? opacity;
  final bool isActive;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? fontHeight;

  const PostcardButton({
    super.key,
    this.isPressed = false,
    this.onTap,
    required this.text,
    this.hasStar = false,
    this.opacity,
    this.isActive = true,
    this.height,
    this.width,
    this.fontSize,
    this.fontHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? getWidth(context, 110),
      height: height ?? getHeight(context, 32),
      child: MvpGradientButton(
        onTap: () {
          onTap?.call();
        },
        fontSize: fontSize?? 12,
        height: fontHeight,
        label: text,
        secondLabel: hasStar ? ' *' : null,
        width: getWidth(context, 110),
        heightFont: 11.18 / 12,
        hasRichText: hasStar,
        opacity: isActive
            ? isPressed
                ? 0.75
                : 0.25
            : 0.1,
        textColor: isActive
            ? isPressed
                ? Colors.white
                : null
            : const Color.fromRGBO(110, 210, 182, 0.5),
      ),
    );
  }
}
