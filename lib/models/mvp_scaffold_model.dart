part of 'models.dart';

class MvpScaffoldModel extends StatelessWidget {
  final Widget? child;
  final String appBarLabel;
  final double? fontSize;

  const MvpScaffoldModel({
    super.key,
    this.child,
    required this.appBarLabel,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return Scaffold(
        backgroundColor:
            state.isDark ? AppTheme.backgroundColor : const Color.fromRGBO(240, 247, 254, 1),
        appBar: CustomAppBar(
          fontSize: fontSize,
          name: appBarLabel,
        ),
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: child,
          ),
        ),
      );
    });
  }
}
