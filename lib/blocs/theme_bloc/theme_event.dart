
abstract class ThemeEvent{

}

class SwitchThemeEvent extends ThemeEvent{
  bool isDark;
  SwitchThemeEvent({required this.isDark});
}