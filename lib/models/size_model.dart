part of 'models.dart';

double getHeight(BuildContext context, double height){
  return height / 812 * MediaQuery.of(context).size.height;
}

double getWidth(BuildContext context, double width){
  return width / 375 * MediaQuery.of(context).size.width;
}