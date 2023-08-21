import 'package:flutter/material.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class PickDateContainer extends StatelessWidget {
  final double height;
  final double width;
  final String label;
  final VoidCallback? onTap;
  final Color? textColor;

  const PickDateContainer({
    super.key,
    required this.height,
    required this.width,
    required this.label,
    this.onTap, this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: SizedBox(
        height: height,
        width: width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(52, 54, 62, 1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1.2,
              color: const Color.fromRGBO(66, 68, 77, 1),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context, 10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextLocalStyles.roboto400.copyWith(
                    color: textColor ?? const Color.fromRGBO(143, 153, 163, 1),
                    fontSize: 12,
                  ),
                ),
                const MoreButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
