part of 'models.dart';

/// Виджет Button для прилоения MVP.
///
/// Принимает одну строку надписи и, опционально, вторую.
/// Имеет градиентную заливку.

class CustomGradientButton extends StatelessWidget {

  final Function onTap;
  final String caption;
  final String? secondCaption;
  final Color leftColor;
  final Color rightColor;

  const CustomGradientButton({
    required this.onTap,
    required this.caption,
    this.secondCaption,
    required this.leftColor,
    required this.rightColor,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [leftColor, rightColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              caption,
              style: customGradientButtonTextStyle,
            ),
            if(secondCaption != null)
              Text(
                secondCaption!,
                style: customGradientButtonTextStyle,
              )
          ]
        )
      ),
      onPointerUp: (_){onTap();}
    );
  }
}