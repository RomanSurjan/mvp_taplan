part of 'models.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final VoidCallback? onTheme;
  final String name;
  final bool hasLightTheme;

  const CustomAppBar({
    super.key,
    this.onBack,
    this.onTheme,
    required this.name,
    this.hasLightTheme = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
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
              Text(
                name,
                style: TextLocalStyles.roboto400.copyWith(
                  fontSize: 18,
                  color: state.appBarTextColor,
                  height: 21.09 / 18,
                ),
                textAlign: TextAlign.center,
              ),
              hasLightTheme
                  ? GradientAnimatedIconButton(
                      icon: state.isDark? 'assets/svg/charm_sun.svg' : 'assets/svg/moon.svg',
                      onPressed: onTheme ?? () {
                        context.read<ThemeBloc>().add(SwitchThemeEvent(isDark: !state.isDark));
                      },
                    )
                  : SizedBox(
                      height: getHeight(context, 40),
                      width: getHeight(context, 40),
                    )
            ],
          ),
        );
      }
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class GradientAnimatedIconButton extends StatefulWidget {
  final String icon;
  final VoidCallback onPressed;

  const GradientAnimatedIconButton({required this.icon, required this.onPressed, Key? key})
      : super(key: key);

  @override
  State<GradientAnimatedIconButton> createState() => _GradientAnimatedIconButtonState();
}

class _GradientAnimatedIconButtonState extends State<GradientAnimatedIconButton> {


  int index = 0;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final gradientColors = [
      context.read<ThemeBloc>().state.appBarButtonBorder,
      [AppTheme.mainGreenColor, AppTheme.mainGreenColor],
      context.read<ThemeBloc>().state.appBarButtonGradient,
    ];
    return Listener(
        child: Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: isPressed ? AppTheme.mainGreenColor : gradientColors[0][0],
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(4, 4),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors[index],
            ),
          ),
          child: Container(
            height: 36,
            width: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors[2],
              ),
            ),
            child: SvgPicture.asset(
              widget.icon,
              colorFilter: ColorFilter.mode(
                isPressed ? AppTheme.mainGreenColor : AppTheme.appBarButtonIconColor,
                BlendMode.srcIn,
              ),
              height: 27,
            ),
          ),
        ),
        onPointerDown: (_) {
          index = 1;
          isPressed = true;

          setState(() {});
        },
        onPointerUp: (_) {
          widget.onPressed.call();
          index = 0;
          isPressed = false;


          setState(() {});
        });
  }
}
