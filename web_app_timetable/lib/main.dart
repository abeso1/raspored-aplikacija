import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/providers/auth_notifier.dart';

import 'package:web_app_timetable/shared/theme/colors.dart';
import 'package:web_app_timetable/views/wrapper/wrapper.dart';

import 'providers/predmeti_notifier.dart';
import 'providers/tab_notifier.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthNotifier()),
        ChangeNotifierProvider.value(value: TabNotifier()),
        ChangeNotifierProvider.value(value: PredmetiNotifier()),
      ],
      child: MaterialApp(
        title: 'Školski raspored',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(textTheme),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.mainGreen,
          ),
        ),
        home: const Wrapper(),
      ),
    );
  }
}
