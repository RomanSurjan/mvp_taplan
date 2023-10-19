part of 'models.dart';

class CustomAppBarRegistration extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final VoidCallback? onTheme;
  final String name;
  final bool hasLightTheme;

  const CustomAppBarRegistration({
    super.key,
    this.onBack,
    this.onTheme,
    required this.name,
    this.hasLightTheme = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: state.isDark
            ? AppTheme.backgroundColor
            : const Color.fromRGBO(240, 247, 254, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GradientAnimatedIconButton(
              icon: 'assets/svg/arrow_back.svg',
              onPressed: onBack ??
                  () {
                    Navigator.pop(context);
                  },
            ),
            Padding(
              padding: EdgeInsets.only(
                top: getHeight(context, 4),
              ),
              child: Text(
                name,
                style: TextLocalStyles.roboto400.copyWith(
                  fontSize: 17,
                  color: state.appBarTextColor,
                  height: 21.09 / 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            hasLightTheme
                ? GradientAnimatedIconButton(
                    icon: state.isDark
                        ? 'assets/svg/charm_sun.svg'
                        : 'assets/svg/moon.svg',
                    onPressed: onTheme ??
                        () {
                          context
                              .read<ThemeBloc>()
                              .add(SwitchThemeEvent(isDark: !state.isDark));
                        },
                  )
                : SizedBox(
                    height: getHeight(context, 40),
                    width: getHeight(context, 40),
                  )
          ],
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
