part of 'screen_215.dart';

class PickYourMoneyContainer extends StatelessWidget {
  final String price;
  final bool isPicked;
  final VoidCallback? onTap;

  const PickYourMoneyContainer({
    super.key,
    required this.price,
    required this.isPicked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: SizedBox(
        height: getHeight(context, 18),
        width: getWidth(context, 66),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isPicked ? const Color.fromRGBO(127, 164, 234, 1) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: const Color.fromRGBO(127, 164, 234, 1),
              width: getWidth(context, 1),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              price,
              style: TextLocalStyles.roboto500.copyWith(
                  color: isPicked ? Colors.white : const Color.fromRGBO(127, 164, 234, 1),
                  fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
