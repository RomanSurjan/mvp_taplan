part of 'screen_214.dart';

class PickUpPriceContainer extends StatelessWidget {
  final String price;
  final String label;
  final bool isPicked;
  final VoidCallback? onTap;
  final Widget? child;

  const PickUpPriceContainer({
    super.key,
    required this.price,
    required this.label,
    this.onTap,
    required this.isPicked,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: SizedBox(
        height: getHeight(context, 40),
        width: getWidth(context, 343),
        child: ColoredBox(
          color: isPicked ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.04),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getWidth(context, 10),
            ),
            child: Row(
              children: [
                Container(
                  height: getHeight(context, 24),
                  width: getWidth(context, 24),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isPicked ? AppTheme.mainGreenColor : AppTheme.pickUpButtonColor,
                      width: getWidth(context, 2),
                    ),
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: isPicked ? AppTheme.mainGreenColor : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getWidth(context, 10),
                  ),
                ),
                if (child == null) ...[
                  Text(
                    label,
                    style: isPicked
                        ? TextLocalStyles.roboto600.copyWith(
                            color: AppTheme.mainGreenColor,
                            fontSize: 16,
                            height: 18.75 / 16,
                          )
                        : TextLocalStyles.roboto400.copyWith(
                            fontSize: 16,
                            height: 18.75 / 16,
                            color: Colors.white,
                          ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    price,
                    style: TextLocalStyles.roboto400.copyWith(
                        color: isPicked ? AppTheme.mainGreenColor : Colors.white, fontSize: 16),
                  ),
                ] else ...[
                  child!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
