import 'package:flutter/material.dart';
import 'package:mvp_taplan/models/models.dart';

class Screen228 extends StatelessWidget {
  const Screen228({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MvpScaffoldModel(
      appBarLabel: 'Платеж на подарок принят ',
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth(context, 16),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getHeight(context, 12),
            ),

          ],
        ),
      ),
    );
  }
}
