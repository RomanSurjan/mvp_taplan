part of 'models.dart';

class MvpGradientButton extends StatelessWidget {
  final String label;
  final LinearGradient? gradient;
  final double width;
  final double? height;
  final VoidCallback? onTap;
  final bool hasRichText;
  final String? secondLabel;
  final double? opacity;
  final double? fontSize;
  final double? heightFont;
  final Color? textColor;

  const MvpGradientButton({
    super.key,
    required this.label,
    this.gradient,
    required this.width,
    this.height,
    this.onTap,
    this.hasRichText = false,
    this.secondLabel,
    this.opacity,
    this.fontSize,
    this.heightFont,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Timer(
          const Duration(milliseconds: 500),
          () {
            onTap?.call();
          },
        );
      },
      child: SizedBox(
        height: height ?? getHeight(context, 44),
        width: width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(98, 198, 170, opacity ?? 0.25),
                Color.fromRGBO(68, 168, 140, opacity ?? 0.25),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color.fromRGBO(82, 182, 154, 1),
              width: 1,
            ),
          ),
          child: Center(
            child: hasRichText
                ? Text.rich(
                    style: TextLocalStyles.roboto600.copyWith(
                      color: textColor ?? (context.watch<ThemeBloc>().state.isDark
                          ? const Color.fromRGBO(110, 210, 182, 1)
                          : const Color.fromRGBO(82, 182, 154, 1)),
                      fontSize: fontSize ?? 13,
                      height: heightFont ?? 15.23 / 13,
                    ),
                    TextSpan(
                      text: label,
                      children: [
                        TextSpan(
                          text: secondLabel,
                          style: TextLocalStyles.roboto600.copyWith(
                            color: Colors.red,
                            fontSize: fontSize ?? 13,
                            height: heightFont ?? 15.23 / 13,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    label,
                    style: TextLocalStyles.roboto600.copyWith(
                      color: textColor ?? (context.watch<ThemeBloc>().state.isDark
                          ? const Color.fromRGBO(110, 210, 182, 1)
                          : const Color.fromRGBO(82, 182, 154, 1)),
                      fontSize: fontSize ?? 13,
                      height: heightFont ?? 15.23 / 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
      ),
    );
  }
}
