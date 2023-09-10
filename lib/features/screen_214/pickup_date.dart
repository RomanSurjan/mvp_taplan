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
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: SizedBox(
          height: getHeight(context, 48),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.read<ThemeBloc>().state.soloBuyDateContainerColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: context.read<ThemeBloc>().state.soloBuyDateBorderColor,
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
                      color: context.read<ThemeBloc>().state.postcardContainerTextColor,
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
