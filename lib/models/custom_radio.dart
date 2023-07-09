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
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value == groupValue){
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.mainGreenColor,
            width: 2,
          ),
          color: AppTheme.backgroundColor
        ),
        child: Center(
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppTheme.mainGreenColor,
            )
          )
        ),
      );
    }
    return Listener(
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.inactiveButtonBorderColor,
            width: 2,
          ),
          color: AppTheme.inactiveButtonFillColor
        ),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
        )
      ),
      onPointerDown: (_) {onChanged(value);},
    );
  }
}