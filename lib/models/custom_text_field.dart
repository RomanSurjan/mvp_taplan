part of 'models.dart';

class CustomTextField extends StatelessWidget {
  final double height;
  final double width;
  final int? maxLines;
  final String? hintText;

  const CustomTextField({
    super.key,
    required this.height,
    required this.width,
    this.maxLines,
    this.hintText,
  });

  static const OutlineInputBorder outlinedBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromRGBO(66, 68, 77, 1),
      width: 1.2,
    ),
    //borderRadius: BorderRadius.circular(8),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        style: TextLocalStyles.roboto400.copyWith(
          color: Colors.white,
          fontSize: getHeight(context, 16),
        ),
        cursorColor: const Color.fromRGBO(166, 173, 181, 1),
        maxLines: maxLines,
        decoration: InputDecoration(
          border: outlinedBorder.copyWith(borderRadius: BorderRadius.circular(8)),
          focusedBorder: outlinedBorder.copyWith(borderRadius: BorderRadius.circular(8)),
          enabledBorder: outlinedBorder.copyWith(borderRadius: BorderRadius.circular(8)),
          hintText: hintText,
          hintStyle: TextLocalStyles.roboto400.copyWith(
            color: const Color.fromRGBO(166, 173, 181, 1),
            fontSize: getHeight(context, 16),
          ),
          filled: true,
          fillColor: const Color.fromRGBO(52, 54, 62, 1),
        ),
      ),
    );
  }
}
