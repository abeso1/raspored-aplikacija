import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/providers/auth_notifier.dart';


import '../admin/admin_view.dart';
import '../dashboard/dashboard_view.dart';
import '../login/login_view.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    return authNotifier.userLoggedIn
        ? authNotifier.userType == UserType.skola
            ? const DashboardView()
            : const AdminView()
        : const LoginView();
  }
}
