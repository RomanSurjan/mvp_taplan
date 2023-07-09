part of 'models.dart';

/// Виджет RadioButton для Экрана "Подарок".
///
/// На экране "present_screen", для которго этот виджет есть список с RadioButton
/// (в две строки).
/// В каждом RadioButton есть ещё вложенные RadioButton с другим дизайном.
/// Вот это те самые вложенные RadioButton.
/// У этого виджета есть три состояния (у каждого состояния свой дизайн):
/// 1. Если выбрана строка, в которой есть эта самая кнопка,
/// и в строке выбрана эта кнопка.
/// 2. Если выбрана строка в которой есть эта кнопка, но сама кнопка не выбрана
/// (в строке могут быть и другие кнопки).
/// 3. Если выбрана другая строка.

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
      // Превый режим. Если вся строка активна и в строке выбрана эта кнопка.
      if (index == groupIndex) {
        return _ButtonContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppTheme.mainBlueColor
          ),
          caption: caption,
          textStyle: customRadioButtonActiveTextStyle,
        );
      }
      // Второй режим.
      return Listener(
        child: _ButtonContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: AppTheme.mainBlueColor,
              width: 1,
            ),
          ),
          caption: caption,
          textStyle: customRadioButtonEnableTextStyle,
        ),
        onPointerDown: (_) {
          onChanged(index);
        },
      );
    }
    // Третий режим.
    return _ButtonContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppTheme.inactiveButtonBorderColor,
          width: 1,
        ),
        color: AppTheme.backgroundColor
      ),
      caption: caption,
      textStyle: customRadioButtonDisableTextStyle,
    );
  }
}

class _ButtonContainer extends StatelessWidget {

  final BoxDecoration decoration;
  final String caption;
  final TextStyle textStyle;

  const _ButtonContainer({
    required this.decoration,
    required this.caption,
    required this.textStyle,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 24,
      decoration: decoration,
      child: Center(
        child: Text(
          caption,
          style: textStyle,
        )
      ),
    );
  }
}