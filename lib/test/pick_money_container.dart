
import 'package:flutter/material.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class PickMoneyContainer extends StatelessWidget {
  final String price;
  final bool isPicked;
  final VoidCallback? onTap;

  const PickMoneyContainer({
    super.key,
    required this.price,
    required this.isPicked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: SizedBox(
        height: getHeight(context, 20),
        width: getWidth(context, 65),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isPicked ? const Color.fromRGBO(127, 164, 234, 1) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: const Color.fromRGBO(127, 164, 234, 1),
              width: getWidth(context, 3),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              price,
              style: TextLocalStyles.roboto500.copyWith(
                color: isPicked ? Colors.white : const Color.fromRGBO(127, 164, 234, 1),
                fontSize: 14,
                height: 16.41 / 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
