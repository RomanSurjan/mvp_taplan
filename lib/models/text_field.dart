part of 'models.dart';

Widget textFieldRegistration(
  BuildContext context, {
  required String hintText,
  required TextEditingController controller,
  required bool isPassword,
  required Color textFieldBorderColor,
}) {
  final OutlineInputBorder outlinedBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: textFieldBorderColor,
      width: 1.2,
    ),
  );
  return SizedBox(
    height: getHeight(context, 52),
    child: TextField(
      expands: //TODO,
          false,
      textInputAction: TextInputAction.done,
      controller: controller,
      textAlignVertical: const TextAlignVertical(y: 1),
      style: TextLocalStyles.roboto400.copyWith(
        color: context.read<ThemeBloc>().state.isDark
            ? const Color.fromRGBO(244, 199, 217, 1)
            : const Color.fromRGBO(166, 173, 181, 1),
        fontSize: getHeight(context, 20),
      ),
      obscureText: isPassword,
      decoration: InputDecoration(
        border: outlinedBorder.copyWith(borderRadius: BorderRadius.circular(6)),
        focusedBorder: outlinedBorder.copyWith(borderRadius: BorderRadius.circular(6)),
        enabledBorder: outlinedBorder.copyWith(borderRadius: BorderRadius.circular(6)),
        hintText: hintText,
        hintStyle: TextLocalStyles.roboto400.copyWith(
          color: context.read<ThemeBloc>().state.isDark
              ? const Color.fromRGBO(105, 113, 119, 1)
              : const Color.fromRGBO(166, 173, 181, 1),
          fontSize: getHeight(context, 20),
          height: 22 / 14,

        ),
        fillColor: context.read<ThemeBloc>().state.isDark
            ? const Color.fromRGBO(52, 54, 62, 1)
            : const Color.fromRGBO(250, 255, 255, 1),
        filled: true,
      ),
    ),
  );
}

Widget iconTextFieldRegistration(
  BuildContext context, {
  required String icon,
  required bool isPressed,
  required Color color,
}) {
  return SizedBox(
    height: getHeight(context, 52),
    width: getHeight(context, 52),
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.read<ThemeBloc>().state.postcardContainerBorderColor,
          width: 1.2,
        ),
        gradient: context.read<ThemeBloc>().state.isDark
            ? isPressed
                ? const LinearGradient(
                    colors: [
                      Color.fromRGBO(74, 79, 85, 1),
                      Color.fromRGBO(44, 49, 55, 1),
                    ],
                    end: Alignment.topLeft,
                    begin: Alignment.bottomRight,
                  )
                : const LinearGradient(
                    colors: [
                      Color.fromRGBO(74, 79, 85, 1),
                      Color.fromRGBO(44, 49, 55, 1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
            : isPressed
                ? const LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(224, 236, 250, 1),
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  )
                : const LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(224, 236, 250, 1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
        // boxShadow: context.read<ThemeBloc>().state.isDark
        //     ? [
        //         const BoxShadow(
        //           offset: Offset(4, 4),
        //           blurRadius: 10,
        //           color: Color.fromRGBO(27, 32, 38, 0.4),
        //         ),
        //         const BoxShadow(
        //           offset: Offset(-4, -4),
        //           blurRadius: 10,
        //           color: Color.fromRGBO(50, 55, 61, 1),
        //         ),
        //       ]
        //     : [
        //         const BoxShadow(
        //           offset: Offset(4, 4),
        //           blurRadius: 10,
        //           color: Color.fromRGBO(154, 189, 230, 0.25),
        //         ),
        //         const BoxShadow(
        //           offset: Offset(-4, -4),
        //           blurRadius: 10,
        //           color: Color.fromRGBO(255, 255, 255, 1),
        //         ),
        //       ],
      ),
      child: SvgPicture.asset(
        icon,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    ),
  );
}
