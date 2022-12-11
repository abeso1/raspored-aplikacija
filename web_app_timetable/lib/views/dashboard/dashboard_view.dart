import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/providers/auth_notifier.dart';
import 'package:web_app_timetable/providers/nastavni_plan_notifier.dart';
import 'package:web_app_timetable/providers/tab_notifier.dart';
import 'package:web_app_timetable/providers/termini_notifier.dart';
import 'package:web_app_timetable/providers/ucionice_notifier.dart';

import '../../providers/grupe_notifier.dart';
import '../../providers/nastavnici_notifier.dart';
import '../../providers/predmeti_notifier.dart';
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
    Provider.of<PredmetiNotifier>(context, listen: false).getPredmeti();
    Provider.of<UcioniceNotifier>(context, listen: false).getUcionice();
    Provider.of<NastavniciNotifier>(context, listen: false).getNastavnici();
    Provider.of<GrupeNotifier>(context, listen: false).getGrupe();
    //Provider.of<TerminiNotifier>(context, listen: false).getTermini();
    Provider.of<NastavniPlanNotifier>(context, listen: false).getNastavniPlan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.white,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(width: 65),
                  Row(
                    children: [
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
                  const SizedBox(width: 15),
                  const Spacer(),
                  Consumer<TabNotifier>(
                    builder: (context, tabNotifier, child) {
                      return Row(
                        children: AppTab.values
                            .map((final tab) => Padding(
                                  padding: EdgeInsets.only(
                                    right: AppTab.values.first == tab ? 90 : 30,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      tabNotifier.setSelectedTab(tab);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 15),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 4,
                                            color:
                                                tabNotifier.selectedTab == tab
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
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Provider.of<AuthNotifier>(context, listen: false)
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
                  const SizedBox(width: 65),
                ],
              ),
            ),
          ),
          Expanded(
            child: Consumer<TabNotifier>(
              builder: (context, tabNotifier, child) {
                if (tabNotifier.selectedTab == AppTab.predmeti) {
                  return const PredmetiView();
                }
                if (tabNotifier.selectedTab == AppTab.ucionice) {
                  return const UcioniceView();
                }
                if (tabNotifier.selectedTab == AppTab.profesori) {
                  return const NastavniciView();
                }
                if (tabNotifier.selectedTab == AppTab.odjeljenja) {
                  return const GrupeView();
                }
                if (tabNotifier.selectedTab == AppTab.termini) {
                  return const TerminiView();
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
