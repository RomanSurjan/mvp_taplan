part of 'screen_214_clothes.dart';

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
          color: isPicked
              ? context.read<ThemeBloc>().state.activePickColor
              : context.read<ThemeBloc>().state.unActivePickColor,
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
                      color: isPicked
                          ? AppTheme.mainGreenColor
                          : context.read<ThemeBloc>().state.pickUpBorerColor,
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
                    left: getWidth(context, 5),
                  ),
                ),
                if (child == null) ...[
                  Text(
                    label,
                    style: isPicked
                        ? TextLocalStyles.roboto600.copyWith(
                            color: AppTheme.mainGreenColor,
                            fontSize: getHeight(context, 17),
                            height: 18.75 / 16,
                          )
                        : TextLocalStyles.roboto400.copyWith(
                            fontSize: getHeight(context, 17),
                            height: 18.75 / 16,
                            color: context.read<ThemeBloc>().state.activeTextColor,
                          ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    price,
                    style: TextLocalStyles.roboto400.copyWith(
                      color: isPicked
                          ? const Color.fromRGBO(127, 164, 234, 1)
                          : context.read<ThemeBloc>().state.activeTextColor,
                      fontSize: getHeight(context, 17),
                    ),
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
