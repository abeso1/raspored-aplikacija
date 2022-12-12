import 'package:flutter/material.dart';
import 'package:web_app_timetable/shared/theme/colors.dart';

class ReusableLoader {
  static BuildContext? _jsLoaderContext;

  static Future<dynamic> showLoader(
    BuildContext context,
  ) async {
    _jsLoaderContext = context;
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.2),
            child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: AppColors.mainGreen,
                )),
          );
        });
  }

  static void popLoader() {
    if (_jsLoaderContext == null || !Navigator.of(_jsLoaderContext!).canPop()) {
      return;
    }
    Navigator.of(_jsLoaderContext!).pop();
    _jsLoaderContext = null;
  }
}
