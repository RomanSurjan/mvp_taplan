part of 'models.dart';

Widget buttonGreen(
    BuildContext context, {
      required double height,
      required double width,
      required String title,
      required double fontSize,
      required VoidCallback onTap,
      required bool isActive,
    }) {
  return InkWell(
    splashColor: isActive ? null : Colors.transparent,
    highlightColor: isActive ? null : Colors.transparent,
    borderRadius: BorderRadius.circular(8),
    onTap: () {
      isActive ? onTap.call() : null;
    },
    child: SizedBox(
      width: getWidth(context, width),
      height: getHeight(context, height),
      child: DecoratedBox(
        decoration: BoxDecoration(
          //TODO
          gradient: LinearGradient(
            colors: isActive ? [
              const Color.fromRGBO(98, 198, 170, 0.3),
              const Color.fromRGBO(68, 168, 140, 0.3),
            ] : [
              const Color.fromRGBO(98, 198, 170, 0.1),
          const Color.fromRGBO(68, 168, 140, 0.1),
          ],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive
                ? const Color.fromRGBO(98, 198, 170, 1)
                : const Color.fromRGBO(98, 198, 170, 0.5),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextLocalStyles.roboto500.copyWith(
              color: isActive
                  ? const Color.fromRGBO(110, 210, 182, 1)
                  : const Color.fromRGBO(110, 210, 182, 0.5),
              fontSize: fontSize,
              height: 16.41 / 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}