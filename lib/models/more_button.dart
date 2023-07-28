part of 'models.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context, 24),
      width: getWidth(context, 24),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(87, 99, 107, 1),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/svg/more_button.svg',
          ),
        ),
      ),
    );
  }
}
