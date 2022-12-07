import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/providers/auth_notifier.dart';
import 'package:web_app_timetable/views/loginView/login_view.dart';

import '../dashboardView/dashboard_view.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    return authNotifier.userLoggedIn
        ? const DashboardView()
        : const LoginView();
  }
}
