part of 'models.dart';

class MvpGradientButton extends StatelessWidget {
  final String label;
  final LinearGradient gradient;
  final double width;

  const MvpGradientButton({
    super.key,
    required this.label,
    required this.gradient, required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context, 44),
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: gradient,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
