part of 'screen_214.dart';

class PickUpDate extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool dateIsPicked;

  const PickUpDate({
    super.key,
    required this.label,
    this.onTap,
    required this.dateIsPicked,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: SizedBox(
          height: getHeight(context, 48),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(55, 57, 65, 1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.borderColor,
                width: getWidth(context, 2),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getWidth(context, 12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      color: !dateIsPicked ? Colors.white : AppTheme.pickUpTextColor,
                    ),
                  ),
                  const MoreButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
