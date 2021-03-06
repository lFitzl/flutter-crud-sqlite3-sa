import 'dart:ui' as ui;

double devicePixelRatio = ui.window.devicePixelRatio;
ui.Size size = ui.window.physicalSize;
double width = size.width;
double height = size.height;
double screenWidth = width / devicePixelRatio;
double screenHeight = height / devicePixelRatio;
ui.Size screenSize = new ui.Size(screenWidth, screenHeight);

double wp(percentage) {
  return percentage / 100 * screenWidth;
}

double hp(percentage) {
  return percentage / 100 * screenHeight;
}
