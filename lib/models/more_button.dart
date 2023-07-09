part of 'models.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context, 24),
      width: getWidth(context, 24),
      child: const DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(87, 99, 107, 1),
          ),
          child: Center(
            child: Icon(
              Icons.more_vert,
              size: 20,
              color: Color.fromRGBO(166, 173, 181, 1),
            ),
          )
      ),
    );
  }
}
