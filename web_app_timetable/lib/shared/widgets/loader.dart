import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:web_app_timetable/shared/theme/colors.dart';

class ReusableLoader {
  static BuildContext? _jsLoaderContext;

  static Future<dynamic> showLoader(BuildContext context,
      {bool withText = false}) async {
    _jsLoaderContext = context;
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 45,
                    width: 45,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      color: AppColors.mainGreen,
                    )),
                if (withText)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Generišem raspored',
                          textStyle: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          cursor: '',
                          speed: const Duration(milliseconds: 50),
                        ),
                        TypewriterAnimatedText(
                          'Ovo može potrajati nekoliko minuta!',
                          textStyle: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          cursor: '',
                          speed: const Duration(milliseconds: 80),
                        ),
                      ],
                      repeatForever: true,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                  ),
              ],
            ),
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
