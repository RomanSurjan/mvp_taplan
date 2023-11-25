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
        height: 35,
        // width: getWidth(context, 343),
        child: ColoredBox(
          color: isPicked
              ? (context.read<ThemeBloc>().state.isDark ? const Color(0xFF4E5057) : const Color.fromRGBO(13, 70, 102, 0.0))
              : context.read<ThemeBloc>().state.unActivePickColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              children: [
                Container(
                  height: 24,
                  width: 24,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isPicked
                          ? AppTheme.mainGreenColor
                          : context.read<ThemeBloc>().state.pickUpBorerColor,
                      width:2,
                    ),
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: isPicked ? AppTheme.mainGreenColor : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5)
                ),
                if (child == null) ...[
                    Expanded(
                      child: Text(
                        label,
                        style: isPicked
                            ? const TextStyle(
                              color: AppTheme.mainGreenColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            )
                            : TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: context.read<ThemeBloc>().state.activeTextColor,
                            ),
                      )
                    ),
                  // const Expanded(child: SizedBox()),
                  Text(
                    price,
                    style: TextStyle(
                      color: isPicked
                          ? AppTheme.mainGreenColor
                          : context.read<ThemeBloc>().state.activeTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400
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
