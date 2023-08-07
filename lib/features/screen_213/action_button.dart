import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final bool hasStar;

  const ActionButton({
    super.key,
    required this.label,
    this.hasStar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: getHeight(context, 32),
          width: getWidth(context, 110),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(110, 210, 182, 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text.rich(
                TextSpan(
                  text: label,
                  style: TextLocalStyles.roboto500.copyWith(
                    fontSize: 12,
                    color: Colors.white,
                    height: 11.18 / 12,
                  ),
                  children: [
                    if (hasStar) ...[
                      TextSpan(
                        text: '*',
                        style: TextLocalStyles.roboto500.copyWith(
                          color: const Color.fromRGBO(218, 80, 80, 1),
                          fontSize: 12,
                          height: 11.18 / 12,
                        ),
                      ),
                    ],
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(
          height: getHeight(context, 32),
          width: getWidth(context, 110),
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(1, 1),
                    blurRadius: 4,
                    spreadRadius: -4,
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                  ),
                  BoxShadow(
                    offset: Offset(-1, -1),
                    blurRadius: 4,
                    spreadRadius: -4,
                    color: Color.fromRGBO(255, 255, 255, 0.24),
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}

class PostcardButton extends StatelessWidget {
  final bool isPressed;
  final VoidCallback? onTap;
  final String text;
  final bool hasStar;

  const PostcardButton({
    super.key,
    this.isPressed = false,
    this.onTap,
    required this.text,
    this.hasStar = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: SizedBox(
        width: getWidth(context, 110),
        height: getHeight(context, 32),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: isPressed
                ? Border.all(
                    width: 2,
                    color: const Color.fromRGBO(82, 182, 154, 1),
                  )
                : null,
            borderRadius: BorderRadius.circular(6),
            color: const Color.fromRGBO(110, 210, 182, 1),
            boxShadow: [
              BoxShadow(
                offset: isPressed ? const Offset(5, 5) : const Offset(-5, -5),
                blurRadius: 4,
                color: const Color.fromRGBO(0, 0, 0, 0.36),
                inset: true,
              ),
              BoxShadow(
                offset: isPressed ? const Offset(-5, -5) : const Offset(5, 5),
                blurRadius: 4,
                color: const Color.fromRGBO(255, 255, 255, 0.55),
                inset: true,
              ),
            ],
          ),
          child: Center(
            child:Text.rich(
              TextSpan(
                text: text,
                style: TextLocalStyles.roboto500.copyWith(
                  fontSize: 12,
                  color: Colors.white,
                  height: 11.18 / 12,
                ),
                children: [
                  if (hasStar) ...[
                    TextSpan(
                      text: '*',
                      style: TextLocalStyles.roboto500.copyWith(
                        color: const Color.fromRGBO(218, 80, 80, 1),
                        fontSize: 12,
                        height: 11.18 / 12,
                      ),
                    ),
                  ],
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
