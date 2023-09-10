part of 'screen_213.dart';

class PickContainer extends StatelessWidget {
  final double height;
  final double width;
  final String label;
  final VoidCallback? onTap;

  const PickContainer({
    super.key,
    required this.height,
    required this.width,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: SizedBox(
        height: height,
        width: width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.read<ThemeBloc>().state.dockColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 1.2,
              color: context.read<ThemeBloc>().state.postcardContainerBorderColor,
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
                    color: context.read<ThemeBloc>().state.postcardContainerTextColor,
                    fontSize: getHeight(context, 16),
                  ),
                ),
                const MoreButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
