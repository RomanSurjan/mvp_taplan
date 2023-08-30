part of 'models.dart';

/// Виджет RadioButton для Экрана "Подарок".

class CustomRadio<T> extends StatelessWidget {
  final ValueChanged<T?> onChanged;
  final T value;
  final T groupValue;

  const CustomRadio({
    required this.onChanged,
    required this.value,
    required this.groupValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (value == groupValue) {
      return Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppTheme.mainGreenColor,
            width: 2,
          ),
        ),
        child: Center(
          child: Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: AppTheme.mainGreenColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }
    return Listener(
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: context.read<ThemeBloc>().state.isDark
                ? AppTheme.inactiveButtonBorderColor
                : const Color.fromRGBO(200, 210, 219, 1),
            width: 2,
          ),
          color: context.read<ThemeBloc>().state.isDark
              ? AppTheme.inactiveButtonFillColor
              : const Color.fromRGBO(229, 232, 247, 1),
        ),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
      ),
      onPointerDown: (_) {
        onChanged(value);
      },
    );
  }
}
