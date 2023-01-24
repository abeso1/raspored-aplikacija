import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/models/termin/termin.dart';
import 'package:web_app_timetable/providers/termini_notifier.dart';
import 'package:web_app_timetable/shared/theme/colors.dart';

import '../../models/termin/dan.dart';
import '../../shared/widgets/loader.dart';

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
                    child: InkWell(
                      onTap: () {
                        Provider.of<TerminiNotifier>(context, listen: false)
                            .setTerminStartDialog(null, notify: false);
                        Provider.of<TerminiNotifier>(context, listen: false)
                            .setTerminEndDialog(null, notify: false);
                        Provider.of<TerminiNotifier>(context, listen: false)
                            .setTerminDayDialog(null, notify: false);
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Consumer<TerminiNotifier>(
                              builder: (context, terminiNotifier, child) {
                                final hour1 = terminiNotifier
                                    .terminStartDialog?.hour
                                    .toString()
                                    .padLeft(2, '0');
                                final minute1 = terminiNotifier
                                    .terminStartDialog?.minute
                                    .toString()
                                    .padLeft(2, '0');

                                final TextEditingController
                                    textEditingController1 =
                                    TextEditingController(
                                  text:
                                      terminiNotifier.terminStartDialog == null
                                          ? null
                                          : '$hour1:$minute1',
                                );

                                final hour2 = terminiNotifier
                                    .terminEndDialog?.hour
                                    .toString()
                                    .padLeft(2, '0');
                                final minute2 = terminiNotifier
                                    .terminEndDialog?.minute
                                    .toString()
                                    .padLeft(2, '0');

                                final TextEditingController
                                    textEditingController2 =
                                    TextEditingController(
                                  text: terminiNotifier.terminEndDialog == null
                                      ? null
                                      : '$hour2:$minute2',
                                );

                                final GlobalKey<FormState> form1Key =
                                    GlobalKey();

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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Dodaj termin',
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
                                        'Unesite dan, početak i kraj termina kojeg želite dodati',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      Row(
                                        children: [
                                          ...Dan.values
                                              .map((e) => Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Radio(
                                                        value: e,
                                                        groupValue:
                                                            terminiNotifier
                                                                .terminDayDialog,
                                                        onChanged: (value) {
                                                          terminiNotifier
                                                              .setTerminDayDialog(
                                                                  value);
                                                        },
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(daniMappedNaBosanski[
                                                          e]!),
                                                      const SizedBox(width: 10),
                                                    ],
                                                  ))
                                              .toList()
                                        ],
                                      ),
                                      const SizedBox(height: 22),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 300,
                                            child: Form(
                                              key: form1Key,
                                              child: TextFormField(
                                                controller:
                                                    textEditingController1,
                                                onTap: () async {
                                                  final newTime =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                    initialEntryMode:
                                                        TimePickerEntryMode
                                                            .input,
                                                    builder: (final context,
                                                            final child) =>
                                                        MediaQuery(
                                                      data:
                                                          MediaQuery.of(context)
                                                              .copyWith(
                                                        alwaysUse24HourFormat:
                                                            true,
                                                      ),
                                                      child: child!,
                                                    ),
                                                  );
                                                  terminiNotifier
                                                      .setTerminStartDialog(
                                                          newTime);
                                                },
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      const Color.fromRGBO(
                                                          9, 30, 66, 0.04),
                                                  hintText: 'Početak',
                                                  hintStyle: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  final dateNow =
                                                      DateTime.now();
                                                  final time1 =
                                                      textEditingController1
                                                          .text
                                                          .split(":");
                                                  final time2 =
                                                      textEditingController2
                                                          .text
                                                          .split(":");
                                                  final start = DateTime(
                                                    dateNow.year,
                                                    dateNow.month,
                                                    dateNow.day,
                                                    int.parse(time1.first),
                                                    int.parse(time1.last),
                                                  );
                                                  final end = DateTime(
                                                    dateNow.year,
                                                    dateNow.month,
                                                    dateNow.day,
                                                    int.parse(time2.first),
                                                    int.parse(time2.last),
                                                  );
                                                  if (start.isAfter(end)) {
                                                    return 'Početka ne može biti poslije kraja';
                                                  }
                                                  if (start
                                                      .isAtSameMomentAs(end)) {
                                                    return 'Početka i kraj ne mogu biti u isto vrijeme';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 22),
                                          SizedBox(
                                            width: 300,
                                            child: TextFormField(
                                              controller:
                                                  textEditingController2,
                                              onTap: () async {
                                                final newTime =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                  initialEntryMode:
                                                      TimePickerEntryMode.input,
                                                  builder: (final context,
                                                          final child) =>
                                                      MediaQuery(
                                                    data: MediaQuery.of(context)
                                                        .copyWith(
                                                      alwaysUse24HourFormat:
                                                          true,
                                                    ),
                                                    child: child!,
                                                  ),
                                                );
                                                terminiNotifier
                                                    .setTerminEndDialog(
                                                        newTime);
                                              },
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                                filled: true,
                                                fillColor: const Color.fromRGBO(
                                                    9, 30, 66, 0.04),
                                                hintText: 'Kraj',
                                                hintStyle: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                border: Border.all(
                                                    color:
                                                        const Color(0xff8d8d8d),
                                                    width: 1),
                                              ),
                                              height: 50,
                                              child: const Center(
                                                child: Text(
                                                  'Odustani',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            flex: 2,
                                            child: InkWell(
                                              onTap: terminiNotifier
                                                              .terminStartDialog !=
                                                          null &&
                                                      terminiNotifier
                                                              .terminEndDialog !=
                                                          null &&
                                                      terminiNotifier
                                                              .terminDayDialog !=
                                                          null
                                                  ? () async {
                                                      if (form1Key.currentState!
                                                          .validate()) {
                                                        ReusableLoader
                                                            .showLoader(
                                                                context);
                                                        await terminiNotifier
                                                            .addTermin();

                                                        ReusableLoader
                                                            .popLoader();
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    }
                                                  : null,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color: terminiNotifier
                                                                  .terminStartDialog !=
                                                              null &&
                                                          terminiNotifier
                                                                  .terminEndDialog !=
                                                              null &&
                                                          terminiNotifier
                                                                  .terminDayDialog !=
                                                              null
                                                      ? AppColors.mainGreen
                                                      : const Color(0xff8d8d8d),
                                                ),
                                                height: 50,
                                                child: const Center(
                                                  child: Text(
                                                    'Dodaj termin',
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
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    terminiNotifier
                                                                        .removeTermin(
                                                                            termin.id!);
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Color(
                                                                        0xff4b4b4b),
                                                                  ),
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
