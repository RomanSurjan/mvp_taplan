import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class ButtonGroup extends StatelessWidget {
  static const blur = 4.0;
  final Color colorMain;
  final String picture;
  final String text;
  final double size;
  final bool isPressed;
  final VoidCallback? onTap;

  const ButtonGroup({
    super.key,
    required this.colorMain,
    required this.picture,
    required this.text,
    required this.size,
    required this.isPressed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: colorMain,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 2,
                color: colorMain,
              ),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(5, 5),
                  blurRadius: blur,
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  inset: true,
                ),
                BoxShadow(
                  offset: Offset(-5, -5),
                  blurRadius: blur,
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  inset: true,
                ),
              ],
            ),
            child: Image.asset(
              picture,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            text,
            style: TextLocalStyles.roboto400.copyWith(
              color: context.read<ThemeBloc>().state.appBarTextColor,
              fontSize: 10,
              height: 11.02 / 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
