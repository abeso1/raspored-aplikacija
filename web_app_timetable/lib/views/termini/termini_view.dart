import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/models/termin/termin.dart';
import 'package:web_app_timetable/providers/termini_notifier.dart';
import 'package:web_app_timetable/shared/theme/colors.dart';

import '../../models/termin/dan.dart';

class TerminiView extends StatefulWidget {
  const TerminiView({super.key});

  @override
  State<TerminiView> createState() => _TerminiViewState();
}

const _rowHeight = 110.0;

class _TerminiViewState extends State<TerminiView> {
  @override
  void initState() {
    super.initState();
    Provider.of<TerminiNotifier>(context, listen: false).getTerminiLoading =
        true;
    Provider.of<TerminiNotifier>(context, listen: false).getTerminiError =
        false;
    Provider.of<TerminiNotifier>(context, listen: false).getTermini();
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
                const SizedBox(width: 30),
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
                              'Dodaj novi termin',
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
        Consumer<TerminiNotifier>(
          builder: (context, terminiNotifier, child) {
            if (terminiNotifier.getTerminiLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (terminiNotifier.getTerminiError) {
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
            if (terminiNotifier.termini.isEmpty) {
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
                          'Hmm izgleda da niste dodali termine',
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
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: const Color(0xffdddddd)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Color(0xffdddddd))),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 100),
                          ...Dan.values.map(
                            (dan) => Expanded(
                              child: Center(
                                child: Text(
                                  daniMappedNaBosanski[dan]!.toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: AppColors.mainGreen),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        ...terminiNotifier.sati!
                                            .map((sat) => Container(
                                                  width: 100,
                                                  height: _rowHeight,
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0xffe7e7e7)),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    sat,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14,
                                                        color: AppColors
                                                            .mainGreen),
                                                  ),
                                                ))
                                            .toList(),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          ...terminiNotifier.sati!
                                              .map(
                                                (sat) => Container(
                                                  width: double.infinity,
                                                  height: _rowHeight,
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 1,
                                                          color: Color(
                                                              0xffe7e7e7)),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: _rowHeight),
                                    ...Dan.values.map((dan) => Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ...terminiNotifier
                                                  .normalisedTermins[dan]!
                                                  .map((termin) {
                                                final DateTime now =
                                                    DateTime.now();
                                                final DateTime start = DateTime(
                                                    now.year,
                                                    now.month,
                                                    now.day,
                                                    (termin).pocetak.hour,
                                                    (termin).pocetak.minute);
                                                final DateTime end = DateTime(
                                                    now.year,
                                                    now.month,
                                                    now.day,
                                                    (termin).kraj.hour,
                                                    (termin).kraj.minute);
                                                return Container(
                                                  width: double.infinity,
                                                  height: end
                                                          .difference(start)
                                                          .inMinutes /
                                                      60 *
                                                      _rowHeight,
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: !termin.show!
                                                      ? null
                                                      : BoxDecoration(
                                                          color: termin.show!
                                                              ? Colors.white
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: const Color(
                                                                  0xffe7e7e7))),
                                                  child: !termin.show!
                                                      ? null
                                                      : Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Početak: ${timeOfDayToString(termin.pocetak)}\nKraj: ${timeOfDayToString(termin.kraj)}',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: const [
                                                                Icon(
                                                                  Icons.edit,
                                                                  color: Color(
                                                                      0xff4b4b4b),
                                                                ),
                                                                Icon(
                                                                  Icons.delete,
                                                                  color: Color(
                                                                      0xff4b4b4b),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                );
                                              }).toList(),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
