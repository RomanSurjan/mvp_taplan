part of 'screen_213.dart';

class PickContainer extends StatelessWidget {
  final double height;
  final double width;
  final String label;

  const PickContainer({
    super.key,
    required this.height,
    required this.width,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(52, 54, 62, 1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1.2,
            color: const Color.fromRGBO(66, 68, 77, 1),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(context, 10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextLocalStyles.roboto400.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  height: 0,
                ),
              ),
              const MoreButton(),
            ],
          ),
        ),
      ),
    );
  }
}
