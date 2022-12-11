import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/shared/theme/colors.dart';

import '../../providers/nastavni_plan_notifier.dart';

class NastavniPlanView extends StatefulWidget {
  const NastavniPlanView({super.key});

  @override
  State<NastavniPlanView> createState() => _NastavniPlanViewState();
}

class _NastavniPlanViewState extends State<NastavniPlanView> {
  @override
  void initState() {
    super.initState();
    Provider.of<NastavniPlanNotifier>(context, listen: false)
        .getNastavniPlanLoading = true;
    Provider.of<NastavniPlanNotifier>(context, listen: false)
        .getNastavniPlanError = false;
    Provider.of<NastavniPlanNotifier>(context, listen: false).getNastavniPlan();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                              'Dodaj novog profesora',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Consumer<NastavniPlanNotifier>(
          builder: (context, nastavniPlanNotifier, child) {
            if (nastavniPlanNotifier.getNastavniPlanLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (nastavniPlanNotifier.getNastavniPlanError) {
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
            if (nastavniPlanNotifier.nastavniPlan.isEmpty) {
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
                          'Hmm izgleda da niste dodali nastavni plan',
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: const Color(0xffdddddd)),
                ),
                child: Column(
                  children: const [],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
