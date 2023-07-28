part of 'models.dart';

class MvpGradientButton extends StatelessWidget {
  final String label;
  final LinearGradient gradient;
  final double width;
  final double? height;
  final TextStyle? style;
  final VoidCallback? onTap;

  const MvpGradientButton({
    super.key,
    required this.label,
    required this.gradient,
    required this.width,
    this.height,
    this.style,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: SizedBox(
        height: height ?? getHeight(context, 44),
        width: width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: gradient,
          ),
          child: Center(
            child: Text(
              label,
              style: style ??
                  TextLocalStyles.roboto600.copyWith(
                    color: Colors.white,
                    fontSize: 13,
                    height: 15.23 / 13,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
