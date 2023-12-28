import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension CustomPadding on num {
  SizedBox get vs => SizedBox(height: toDouble().h);
  SizedBox get hs => SizedBox(width: toDouble().w);
}

extension NavigationExtensions on BuildContext {
  void pushNamedRoute(String routeName) {
    Navigator.pushNamed(
      this,
      routeName,
    );
  }
}

extension NavigationExtension on NavigatorState {
  Future pushScreen(Widget screen) async {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );
  }
}

extension NewCustomPadding on num {
  SizedBox vspacing(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double padding = this.toDouble() * screenHeight / 100.0;
    return SizedBox(height: padding / MediaQuery.of(context).devicePixelRatio);
  }

  SizedBox hspacing(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = this.toDouble() * screenWidth / 100.0;
    return SizedBox(width: padding / MediaQuery.of(context).devicePixelRatio);
  }
}
