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
          color: AppTheme.backgroundColor,
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
            color: AppTheme.inactiveButtonBorderColor,
            width: 2,
          ),
          color: AppTheme.inactiveButtonFillColor,
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
