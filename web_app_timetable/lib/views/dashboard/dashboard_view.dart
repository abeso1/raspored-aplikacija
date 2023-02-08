import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/providers/auth_notifier.dart';
import 'package:web_app_timetable/providers/nastavni_plan_notifier.dart';
import 'package:web_app_timetable/providers/tab_notifier.dart';
import 'package:web_app_timetable/providers/termini_notifier.dart';
import 'package:web_app_timetable/providers/ucionice_notifier.dart';
import 'package:web_app_timetable/views/nastavni_plan/nastavni_plan_view.dart';
import 'package:web_app_timetable/views/raspored/raspored_view.dart';

import '../../providers/grupe_notifier.dart';
import '../../providers/nastavnici_notifier.dart';
import '../../providers/predmeti_notifier.dart';
import '../../providers/raspored_notifier.dart';
import '../../shared/theme/colors.dart';
import '../grupe/grupe_view.dart';
import '../nastavnici/nastavnici_view.dart';
import '../predmeti/predmeti_view.dart';
import '../termini/termini_view.dart';
import '../ucionice/ucionice_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    final AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    Provider.of<PredmetiNotifier>(context, listen: false)
        .setSkolaId(authNotifier.skolaId);
    Provider.of<PredmetiNotifier>(context, listen: false).getPredmeti();
    Provider.of<UcioniceNotifier>(context, listen: false)
        .setSkolaId(authNotifier.skolaId);
    Provider.of<UcioniceNotifier>(context, listen: false).getUcionice();
    Provider.of<NastavniciNotifier>(context, listen: false)
        .setSkolaId(authNotifier.skolaId);
    Provider.of<NastavniciNotifier>(context, listen: false).getNastavnici();
    Provider.of<GrupeNotifier>(context, listen: false)
        .setSkolaId(authNotifier.skolaId);
    Provider.of<GrupeNotifier>(context, listen: false).getGrupe();
    Provider.of<TerminiNotifier>(context, listen: false)
        .setSkolaId(authNotifier.skolaId);
    Provider.of<TerminiNotifier>(context, listen: false).getTermini();
    Provider.of<NastavniPlanNotifier>(context, listen: false)
        .setSkolaId(authNotifier.skolaId);
    Provider.of<NastavniPlanNotifier>(context, listen: false).getNastavniPlan();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: RasporedNotifier(
          nastavniPlanNotifier: Provider.of<NastavniPlanNotifier>(context),
          terminiNotifier: Provider.of<TerminiNotifier>(context),
          ucioniceNotifier: Provider.of<UcioniceNotifier>(context),
          authNotifier: Provider.of<AuthNotifier>(context),
        )),
      ],
      child: Scaffold(
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
                            const SizedBox(width: 10),
                            Consumer<TabNotifier>(
                              builder: (context, tabNotifier, child) {
                                return Row(
                                  children: AppTab.values
                                      .map((final tab) => Padding(
                                            padding: EdgeInsets.only(
                                              right: AppTab.values.first == tab
                                                  ? 90
                                                  : 30,
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                tabNotifier.setSelectedTab(tab);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3,
                                                        vertical: 15),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      width: 4,
                                                      color: tabNotifier
                                                                  .selectedTab ==
                                                              tab
                                                          ? AppColors.mainGreen
                                                          : Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  tabNotifier.tabNames[tab]!,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                );
                              },
                            ),
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
              child: Consumer<TabNotifier>(
                builder: (context, tabNotifier, child) {
                  switch (tabNotifier.selectedTab) {
                    case AppTab.predmeti:
                      return const PredmetiView();

                    case AppTab.ucionice:
                      return const UcioniceView();

                    case AppTab.profesori:
                      return const NastavniciView();

                    case AppTab.odjeljenja:
                      return const GrupeView();

                    case AppTab.termini:
                      return const TerminiView();

                    case AppTab.nastavniplan:
                      return const NastavniPlanView();

                    case AppTab.raspored:
                      return const RasporedView();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
