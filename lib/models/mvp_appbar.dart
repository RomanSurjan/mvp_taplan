part of 'models.dart';



/// AppBar для MVP.
///
/// Принимает одну строку заголовка и, опуионально, вторую.

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function callBack;
  final String name;
  final String? secondName;

  /// Constructor.
  const CustomAppBar({
    required this.callBack,
    required this.name,
    this.secondName,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppTheme.appBarMainColor,
        height: 49,
        child: Row(
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(left: 14),
                  child: GradientAnimatedIconButton(
                    icon: Icons.arrow_back_ios_new_outlined,
                    onPressed: callBack,
                  )
              ),
              Expanded(
                  child: Center(
                      child: Text(
                        name,
                        style: appBarNameTextStyle,
                      )
                  )
              ),
              Container(
                  margin: const EdgeInsets.only(right: 14),
                  child: GradientAnimatedIconButton(
                    icon: Icons.wb_sunny_outlined,
                    onPressed: callBack,
                  )
              )
            ]
        )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(49);

}

/// Buttons with click animation at the icon shadow and border (color changes).
/// The button itself has a gradient and a gradient border.
class GradientAnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final Function onPressed;

  const GradientAnimatedIconButton({
    required this.icon,
    required this.onPressed,
    Key? key
  }) : super(key: key);

  @override
  State<GradientAnimatedIconButton> createState() => _GradientAnimatedIconButtonState();
}

class _GradientAnimatedIconButtonState extends State<GradientAnimatedIconButton> {
  int index = 0;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    Color green = AppTheme.mainGreenColor;
    Color color1 = AppTheme.appBarButtonBorderColor1;
    Color color2 = AppTheme.appBarButtonBorderColor2;
    Color color3 = AppTheme.appBarButtonFillColor1;
    Color color4 = AppTheme.appBarButtonFillColor2;
    Color iconColor = AppTheme.appBarButtonIconColor;
    List<List<Color>> gradientColours = [[color1, color2],[green, green]];

    return Listener(
        child: Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                boxShadow: [
                  BoxShadow(
                    color: isPressed ? green : color1,
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: const Offset(0, 0),
                  ),
                ],
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColours[index]
                )
            ),
            child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [color4, color3]
                    )
                ),
                child: SizedBox(
                    width: 16,
                    height: 16,
                    child: isPressed?
                    Icon(widget.icon, color: green):
                    Icon(widget.icon, color: iconColor)
                )
            )
        ),
        onPointerDown: (_) {
          setState(() {
            index = 1;
            isPressed = true;
          });
        },
        onPointerUp: (_) {
          setState(() {
            index = 0;
            isPressed = false;
          });
          widget.onPressed();
        }
    );
  }
}