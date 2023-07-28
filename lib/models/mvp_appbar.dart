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
    this.hasLightTheme = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppTheme.appBarManeColor,
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
              color: Colors.white,
              height: 21.09 / 18,
            ),
            textAlign: TextAlign.center,
          ),
          hasLightTheme
              ? GradientAnimatedIconButton(
                  icon: 'assets/svg/charm_sun.svg',
                  onPressed: onTheme ?? () {},
                )
              : SizedBox(
                  height: getHeight(context, 40),
                  width: getHeight(context, 40),
                )
        ],
      ),
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
  static const gradientColors = [
    [AppTheme.appBarButtonFirstBorderColor, AppTheme.appBarButtonSecondBorderColor],
    [AppTheme.mainGreenColor, AppTheme.mainGreenColor],
    [AppTheme.appBarButtonFillColor2, AppTheme.appBarButtonFillColor1],
  ];

  int index = 0;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
        child: Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: isPressed ? AppTheme.mainGreenColor : AppTheme.appBarButtonFirstBorderColor,
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
          index = 0;
          isPressed = false;

          widget.onPressed.call();
          setState(() {});
        });
  }
}
