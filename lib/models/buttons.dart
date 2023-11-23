import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:mvp_taplan/blocs/theme_bloc/theme_bloc.dart';
import 'package:mvp_taplan/models/models.dart';
import 'package:mvp_taplan/theme/text_styles.dart';

class ButtonGroup extends StatelessWidget {
  static const blur = 4.0;
  final Color colorMain;
  final String picture;
  final Color colorCount;
  final String text;
  final bool isPressed;
  final VoidCallback onTap;
  final int count;
  final String date;

  const ButtonGroup({
    super.key,
    required this.colorMain,
    required this.picture,
    required this.colorCount,
    required this.text,
    required this.isPressed,
    required this.onTap,
    required this.count, required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        onTap.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 3, top: 3),
                child: Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: isPressed ? const Color.fromRGBO(98, 198, 170, 1) : const Color.fromRGBO(98, 198, 170, 0.35),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: colorMain),
                  ),
                  child: SvgPicture.asset(
                    picture,
                    height: 40,
                    width: 44,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(isPressed ? const Color.fromRGBO(255, 255, 255, 1) : const Color.fromRGBO(66, 157, 132, 1), BlendMode.srcIn),
                  ),
                ),
              ),
              Container(
                width: 19,
                height: 19,
                decoration: BoxDecoration(
                  color: colorCount,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(width: 1, color: colorMain),
                ),
                child: Text(
                  count.toString(),
                  textAlign: TextAlign.center,
                  style: TextLocalStyles.roboto500.copyWith(
                    color: const Color.fromRGBO(57, 57, 57, 1),
                    fontSize: 13,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            text,
            style: TextLocalStyles.roboto500.copyWith(
              fontWeight: isPressed ? FontWeight.w600 : FontWeight.w400,
              fontSize: 12,
              color: !context.read<ThemeBloc>().state.isDark
                  ? const Color.fromRGBO(22, 26, 29, 1)
                  : const Color.fromRGBO(233, 235, 237, 1),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            date,
            style: TextLocalStyles.roboto500.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: !context.read<ThemeBloc>().state.isDark
                  ? const Color.fromRGBO(22, 26, 29, 1)
                  : const Color.fromRGBO(233, 235, 237, 1),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonGroupWish extends StatelessWidget {
  static const blur = 4.0;
  final Color colorMain;
  final String picture;
  final Color colorCount;
  final String text;
  final bool isPressed;
  final VoidCallback onTap;

  const ButtonGroupWish({
    super.key,
    required this.colorMain,
    required this.picture,
    required this.colorCount,
    required this.text,
    required this.isPressed,
    required this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        onTap.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  color: colorMain,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: colorMain),
                  boxShadow: [
                    BoxShadow(
                      offset:
                      isPressed ? const Offset(5, 5) : const Offset(-5, -5),
                      blurRadius: blur,
                      color: const Color.fromRGBO(0, 0, 0, 0.3),
                      inset: true,
                    ),
                    BoxShadow(
                      offset:
                      isPressed ? const Offset(-5, -5) : const Offset(5, 5),
                      blurRadius: blur,
                      color: const Color.fromRGBO(255, 255, 255, 0.4),
                      inset: true,
                    ),
                  ],
                ),
                child: Image.asset(picture, height: 40, width: 44,),
                // child: SvgPicture.asset(
                //   picture,
                //   height: 40,
                //   width: 44,
                //   fit: BoxFit.scaleDown,
                // ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextLocalStyles.roboto500.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: 11,
              color: !context.read<ThemeBloc>().state.isDark
                  ? const Color.fromRGBO(22, 26, 29, 1)
                  : const Color.fromRGBO(233, 235, 237, 1),
            ),
          ),
        ],
      ),
    );
  }
}

class PickCelebrateButton extends StatelessWidget {
  final bool isPressed;
  final VoidCallback? onTap;
  final String label;

  const PickCelebrateButton({
    Key? key,
    required this.isPressed,
    this.onTap,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context, 164),
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color.fromRGBO(110, 210, 182, 1),
            boxShadow: [
              BoxShadow(
                offset: isPressed ? const Offset(5, 5) : const Offset(-5, -5),
                blurRadius: 10,
                color: const Color.fromRGBO(0, 0, 0, 0.5),
                inset: true,
              ),
              BoxShadow(
                offset: isPressed ? const Offset(-5, -5) : const Offset(5, 5),
                blurRadius: 10,
                color: const Color.fromRGBO(255, 255, 255, 0.5),
                inset: true,
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: getHeight(context, 6),
              ),
              child: Text(
                label,
                style: TextLocalStyles.roboto500.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  height: 0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavButton extends StatelessWidget {
  final String picture;
  final bool isPressed;
  final VoidCallback onTap;

  const BottomNavButton({
    required this.picture,
    required this.isPressed,
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      borderRadius: BorderRadius.circular(8),
      child: !context.read<ThemeBloc>().state.isDark
          ? Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(230, 241, 254, 1),
                    borderRadius: BorderRadius.circular(10),
                    gradient: isPressed
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(255, 255, 255, 1),
                              Color.fromRGBO(224, 236, 250, 1),
                            ],
                          )
                        : null,
                  ),
                ),
                Container(
                  width: 53,
                  height: 53,
                  decoration: BoxDecoration(
                    color: isPressed
                        ? const Color.fromRGBO(224, 236, 250, 1)
                        : const Color.fromRGBO(230, 241, 254, 1),
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                        offset: isPressed ? Offset.zero : const Offset(4, 4),
                        blurRadius: isPressed ? 10 : 10,
                        color: const Color.fromRGBO(154, 189, 230, 0.3),
                      ),
                      BoxShadow(
                        offset: const Offset(-4, -4),
                        blurRadius: isPressed ? 10 : 15,
                        color: isPressed
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(154, 189, 230, 0.6),
                        inset: true,
                      ),
                      BoxShadow(
                        offset: const Offset(4, 4),
                        blurRadius: isPressed ? 10 : 10,
                        color: isPressed
                            ? const Color.fromRGBO(147, 182, 223, 0.2)
                            : const Color.fromRGBO(255, 255, 255, 1),
                        inset: true,
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    picture,
                    height: 35,
                    width: 35,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(
                        isPressed
                            ? const Color.fromRGBO(98, 198, 170, 1)
                            : const Color.fromRGBO(200, 210, 219, 1),
                        BlendMode.srcIn),
                  ),
                ),
              ],
            )
          : Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isPressed
                    ? const Color.fromRGBO(67, 72, 78, 1)
                    : const Color.fromRGBO(70, 72, 81, 1),
                borderRadius: BorderRadius.circular(10),
                border: isPressed
                    ? Border.all(
                        width: 2, color: const Color.fromRGBO(67, 72, 78, 1))
                    : null,
                boxShadow: [
                  BoxShadow(
                    offset: isPressed
                        ? const Offset(-4, -4)
                        : const Offset(-10, -13),
                    blurRadius: isPressed ? 10 : 10,
                    color: isPressed
                        ? const Color.fromRGBO(66, 69, 72, 1)
                        : const Color.fromRGBO(40, 43, 51, 1),
                    inset: true,
                  ),
                  BoxShadow(
                    offset: isPressed ? const Offset(4, 4) : const Offset(1, 1),
                    blurRadius: isPressed ? 10 : 7,
                    color: isPressed
                        ? const Color.fromRGBO(0, 5, 11, 0.4)
                        : const Color.fromRGBO(255, 255, 255, 0.3),
                    inset: true,
                  ),
                ],
              ),
              child: SvgPicture.asset(
                picture,
                height: 35,
                width: 35,
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                    isPressed
                        ? const Color.fromRGBO(98, 198, 170, 1)
                        : const Color.fromRGBO(143, 153, 163, 1),
                    BlendMode.srcIn),
              ),
            ),
    );
  }
}

class BottomNavButtonNotActive extends StatelessWidget {
  final String picture;

  const BottomNavButtonNotActive({
    required this.picture,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !context.read<ThemeBloc>().state.isDark
        ? Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(230, 241, 254, 1),
                  borderRadius: BorderRadius.circular(10),
                  gradient: null,
                ),
              ),
              Container(
                width: 53,
                height: 53,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(230, 241, 254, 1),
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(4, 4),
                      blurRadius: 10,
                      color: Color.fromRGBO(154, 189, 230, 0.3),
                    ),
                    BoxShadow(
                      offset: Offset(-4, -4),
                      blurRadius: 15,
                      color: Color.fromRGBO(154, 189, 230, 0.6),
                      inset: true,
                    ),
                    BoxShadow(
                      offset: Offset(4, 4),
                      blurRadius: 10,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      inset: true,
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  picture,
                  height: 35,
                  width: 35,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                      Color.fromRGBO(78, 91, 105, 1), BlendMode.srcIn),
                ),
              ),
            ],
          )
        : Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(70, 72, 81, 1),
              borderRadius: BorderRadius.circular(10),
              border: null,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(-10, -13),
                  blurRadius: 10,
                  color: Color.fromRGBO(40, 43, 51, 1),
                  inset: true,
                ),
                BoxShadow(
                  offset: Offset(1, 1),
                  blurRadius: 7,
                  color: Color.fromRGBO(255, 255, 255, 0.3),
                  inset: true,
                ),
              ],
            ),
            child: SvgPicture.asset(
              picture,
              height: 35,
              width: 35,
              fit: BoxFit.scaleDown,
              colorFilter: const ColorFilter.mode(
                  Color.fromRGBO(78, 91, 105, 1), BlendMode.srcIn),
            ),
          );
  }
}

class BottomNavCenterButton extends StatelessWidget {
  final bool isPressed;
  final VoidCallback onTap;

  const BottomNavCenterButton({
    required this.isPressed,
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Container(
        width: 73,
        height: 73,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: !context.read<ThemeBloc>().state.isDark
              ? const Color.fromRGBO(224, 236, 250, 1)
              : const Color.fromRGBO(70, 72, 81, 1),
          border: Border.all(
            width: 2,
            color: const Color.fromRGBO(98, 198, 170, 1),
          ),
          boxShadow: [
            BoxShadow(
              offset: isPressed ? const Offset(-4, -4) : const Offset(4, 4),
              blurRadius: 10,
              color: !context.read<ThemeBloc>().state.isDark
                  ? const Color.fromRGBO(255, 255, 255, 1)
                  : const Color.fromRGBO(255, 255, 255, 0.3),
              inset: true,
            ),
            BoxShadow(
              offset: isPressed ? const Offset(4, 4) : const Offset(-4, -4),
              blurRadius: 10,
              color: !context.read<ThemeBloc>().state.isDark
                  ? const Color.fromRGBO(161, 196, 237, 0.3)
                  : const Color.fromRGBO(40, 43, 51, 1),
              inset: true,
            ),
          ],
        ),
        child: SvgPicture.asset(
          'assets/svg/present.svg',
          height: 37,
          width: 37,
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(
            isPressed
                ? const Color.fromRGBO(98, 198, 170, 1)
                : const Color.fromRGBO(200, 210, 219, 1),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class BottomNavCenterButtonNotActive extends StatelessWidget {
  const BottomNavCenterButtonNotActive({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 73,
      height: 73,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: !context.read<ThemeBloc>().state.isDark
            ? const Color.fromRGBO(224, 236, 250, 1)
            : const Color.fromRGBO(70, 72, 81, 1),
        border: Border.all(
          width: 2,
          color: const Color.fromRGBO(78, 91, 105, 1),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 10,
            color: !context.read<ThemeBloc>().state.isDark
                ? const Color.fromRGBO(255, 255, 255, 1)
                : const Color.fromRGBO(255, 255, 255, 0.3),
            inset: true,
          ),
          BoxShadow(
            offset: const Offset(-4, -4),
            blurRadius: 10,
            color: !context.read<ThemeBloc>().state.isDark
                ? const Color.fromRGBO(161, 196, 237, 0.3)
                : const Color.fromRGBO(40, 43, 51, 1),
            inset: true,
          ),
        ],
      ),
      child: SvgPicture.asset(
        'assets/svg/present.svg',
        height: 37,
        width: 37,
        fit: BoxFit.scaleDown,
        colorFilter: const ColorFilter.mode(
          Color.fromRGBO(78, 91, 105, 1),
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
