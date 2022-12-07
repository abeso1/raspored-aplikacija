import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/providers/auth_notifier.dart';

import '../../shared/theme/colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? mail;
  String? password;

  setMail(String value) {
    setState(() {
      mail = value;
    });
  }

  setPassword(String value) {
    setState(() {
      password = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Row(
                    children: [
                      Text(
                        'ŠKOLSKI',
                        style: TextStyle(
                            color: AppColors.mainGreen,
                            fontSize: 34,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'RASPORED',
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 34,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    const Text(
                      'Dobrodošli nazad',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 450,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3)),
                          hintText: 'Unesite mail',
                        ),
                        onChanged: (value) => setMail(value),
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: 450,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3)),
                          hintText: 'Unesite lozinku',
                        ),
                        obscureText: true,
                        onChanged: (value) => setPassword(value),
                      ),
                    ),
                    const SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        if (mail == null ||
                            password == null ||
                            Provider.of<AuthNotifier>(context, listen: false)
                                .login(mail!, password!)) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Netačan mail ili lozinka!'),
                          ));
                        }
                      },
                      child: Container(
                        width: 450,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: AppColors.mainGreen),
                        child: const Center(
                          child: Text(
                            'Prijavi se',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: AppColors.mainGreen,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Pozdrav!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Trebate pomoć pri korištenju platforme?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(36)),
                    height: 50,
                    width: 250,
                    child: const Center(
                      child: Text(
                        'Kontaktirajte nas',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
