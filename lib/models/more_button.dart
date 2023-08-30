part of 'models.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return SizedBox(
          height: getHeight(context, 24),
          width: getWidth(context, 24),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: state.isDark ? const Color.fromRGBO(87, 99, 107, 1) : const Color.fromRGBO(237, 244, 251, 1),
            ),
            child: Center(
              child: SvgPicture.asset(
                state.isDark ? 'assets/svg/more_button.svg' : 'assets/svg/more_button_light.svg',
              ),
            ),
          ),
        );
      }
    );
  }
}
