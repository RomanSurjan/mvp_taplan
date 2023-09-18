import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:mvp_taplan/models/models.dart';

class PostcardButton extends StatelessWidget {
  final bool isPressed;
  final VoidCallback? onTap;
  final String text;
  final bool hasStar;
  final double? opacity;
  final bool isActive;

  const PostcardButton({
    super.key,
    this.isPressed = false,
    this.onTap,
    required this.text,
    this.hasStar = false,
    this.opacity,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context, 110),
      height: getHeight(context, 32),
      child: MvpGradientButton(
        onTap: (){
          onTap?.call();
        },
        fontSize: 12,
        label: text,
        secondLabel: hasStar ? ' *' : null,
        width: getWidth(context, 110),
        heightFont: 11.18 / 12,
        hasRichText: hasStar,
        opacity: isActive? isPressed ? 0.75 : 0.25 : 0.1,
        textColor: isActive ? isPressed ? Colors.white : null : const Color.fromRGBO(110, 210, 182, 0.5),
      ),
    );
  }
}
