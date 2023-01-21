import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_notifier.dart';
import '../../providers/skole_notifier.dart';
import '../../shared/theme/colors.dart';
import '../../shared/widgets/loader.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  @override
  void initState() {
    Provider.of<SkoleNotifier>(context, listen: false).getSkole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  color: Colors.white,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 300,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Spacer(),
                                      Text(
                                        'ŠKOLSKI',
                                        style: TextStyle(
                                            color: AppColors.mainGreen,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'RASPORED',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 300,
                                  child: Row(
                                    children: const [
                                      Spacer(),
                                      Text(
                                        'UNVI Team',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 2),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: InkWell(
                              onTap: () {
                                Provider.of<AuthNotifier>(context,
                                        listen: false)
                                    .logout();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 15),
                                child: const Text(
                                  'Odjavi se',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        const Spacer(flex: 8),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          flex: 3,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Consumer<SkoleNotifier>(
                                    builder: (context, skoleNotifier, child) {
                                      return Container(
                                        width: 800,
                                        height: 600,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 80, vertical: 60),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Dodaj školu',
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Icon(
                                                    size: 40,
                                                    Icons.close,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 24),
                                            const Text(
                                              'Popunite tražena polja',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 40),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                                filled: true,
                                                fillColor: const Color.fromRGBO(
                                                    9, 30, 66, 0.04),
                                                hintText: 'Unesite naziv',
                                                hintStyle: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              onChanged: (value) =>
                                                  skoleNotifier
                                                      .setNazivDialog(value),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                                filled: true,
                                                fillColor: const Color.fromRGBO(
                                                    9, 30, 66, 0.04),
                                                hintText: 'Unesite adresu',
                                                hintStyle: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              onChanged: (value) =>
                                                  skoleNotifier
                                                      .setAdresaDialog(value),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                                filled: true,
                                                fillColor: const Color.fromRGBO(
                                                    9, 30, 66, 0.04),
                                                hintText: 'Unesite mail',
                                                hintStyle: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              onChanged: (value) =>
                                                  skoleNotifier
                                                      .setEmailDialog(value),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                                filled: true,
                                                fillColor: const Color.fromRGBO(
                                                    9, 30, 66, 0.04),
                                                hintText: 'Unesite lozinku',
                                                hintStyle: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              onChanged: (value) =>
                                                  skoleNotifier
                                                      .setLozinkaDialog(value),
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xff8d8d8d),
                                                          width: 1),
                                                    ),
                                                    height: 50,
                                                    child: const Center(
                                                      child: Text(
                                                        'Odustani',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 15),
                                                Expanded(
                                                  flex: 2,
                                                  child: InkWell(
                                                    onTap: skoleNotifier
                                                                    .nazivDialog !=
                                                                null &&
                                                            skoleNotifier
                                                                    .adresaDialog !=
                                                                null &&
                                                            skoleNotifier
                                                                    .emailDialog !=
                                                                null &&
                                                            skoleNotifier
                                                                    .lozinkaDialog !=
                                                                null
                                                        ? () async {
                                                            ReusableLoader
                                                                .showLoader(
                                                                    context);
                                                            await skoleNotifier
                                                                .addSkolu();
                                                            ReusableLoader
                                                                .popLoader();
                                                            // ignore: use_build_context_synchronously
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        : null,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                        color: skoleNotifier
                                                                        .nazivDialog !=
                                                                    null &&
                                                                skoleNotifier
                                                                        .adresaDialog !=
                                                                    null &&
                                                                skoleNotifier
                                                                        .emailDialog !=
                                                                    null &&
                                                                skoleNotifier
                                                                        .lozinkaDialog !=
                                                                    null
                                                            ? AppColors
                                                                .mainGreen
                                                            : const Color(
                                                                0xff8d8d8d),
                                                      ),
                                                      height: 50,
                                                      child: const Center(
                                                        child: Text(
                                                          'Dodaj školu',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.mainGreen,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Dodaj novu školu',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Consumer<SkoleNotifier>(
                    builder: (context, skoleNotifier, child) {
                  if (skoleNotifier.getSkoleLoading) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (skoleNotifier.getSkoleError) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        'Došlo je do greške!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }
                  if (skoleNotifier.skole.isEmpty) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              const Text(
                                'Hmm izgleda da niste dodali profesore',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Učinite to klikom na ovo dugme',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 80),
                              Image.asset(
                                'assets/images/empty.png',
                                height: 200,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/arrow.png',
                                height: 100,
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          margin: const EdgeInsets.fromLTRB(50, 0, 50, 20),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Color(0xffcdcdcd),
                              ),
                            ),
                          ),
                          child: Row(
                            children: const [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Naziv',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Adresa',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Mail',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Opcije',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Column(
                              children: skoleNotifier.skole
                                  .map((skola) => Container(
                                        padding: const EdgeInsets.all(20),
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                skola.naziv,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                skola.adresa,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                skola.email,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                children: [
                                                  const Spacer(),
                                                  InkWell(
                                                    onTap: () {
                                                      skoleNotifier.removeSkolu(
                                                          skola.id);
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Color(0xff4b4b4b),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
