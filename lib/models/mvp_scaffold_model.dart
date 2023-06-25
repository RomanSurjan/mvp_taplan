part of 'models.dart';

class MvpScaffoldModel extends StatelessWidget {
  final Widget? child;
  final String appBarLabel;

  const MvpScaffoldModel({
    super.key,
    this.child,
    required this.appBarLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
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
  }
}
