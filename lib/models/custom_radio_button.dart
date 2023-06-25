part of 'models.dart';

/// Виджет RadioButton для Экрана "Подарок".
///
/// Должен быть вложен как title в друой radio button.
/// Имеет три режима отображения:
/// 1. Выбран.
/// 2. Не выбран, но может быть выбран.
/// 3. Не может быть выбран.

class CustomRadioButton extends StatelessWidget {

  final ValueChanged onChanged;
  final String caption;
  final int index;
  final int groupIndex;
  final bool isActive;

  const CustomRadioButton({
    required this.onChanged,
    required this.caption,
    required this.index,
    required this.groupIndex,
    required this.isActive,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      // Превый режим.
      if (index == groupIndex) {
        return Container(
          width: 72,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppTheme.mainBlueColor
          ),
          child: Center(
            child: Text(
              caption,
              style: customRadioButtonActiveTextStyle,
            )
          ),
        );
      }
      // Второй режим.
      return Listener(
        child: Container(
          height: 24,
          width: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: AppTheme.mainBlueColor,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              caption,
              style: customRadioButtonEnableTextStyle,
            )
          ),
        ),
        onPointerDown: (_) {
          onChanged(index);
        },
      );
    }
    // Третий режим.
    return Container(
      width: 72,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppTheme.inactiveButtonBorderColor,
          width: 1,
        ),
        color: AppTheme.backgroundColor
      ),
      child: Center(
        child: Center(
          child: Text(
          caption,
            style: customRadioButtonDisableTextStyle,
          )
        ),
      ),
    );
  }
}