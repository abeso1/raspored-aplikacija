import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/providers/auth_notifier.dart';

import 'package:web_app_timetable/shared/theme/colors.dart';
import 'package:web_app_timetable/views/wrapper/wrapper.dart';

import 'views/loginView/login_view.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthNotifier()),
      ],
      child: MaterialApp(
        title: 'Školski raspored',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //textTheme: GoogleFonts.montserratTextTheme(textTheme),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.mainGreen,
          ),
        ),
        home: const Wrapper(),
      ),
    );
  }
}
