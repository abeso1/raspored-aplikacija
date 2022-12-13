import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/providers/grupe_notifier.dart';
import 'package:web_app_timetable/providers/nastavni_plan_notifier.dart';
import 'package:web_app_timetable/providers/nastavnici_notifier.dart';
import 'package:web_app_timetable/providers/predmeti_notifier.dart';
import 'package:web_app_timetable/providers/raspored_notifier.dart';
import 'package:web_app_timetable/shared/widgets/loader.dart';
import 'package:web_app_timetable/views/raspored/pdf_view.dart';

import '../../models/termin/dan.dart';
import '../../models/termin/termin.dart';
import '../../providers/termini_notifier.dart';
import '../../providers/ucionice_notifier.dart';
import '../../shared/theme/colors.dart';

class RasporedView extends StatefulWidget {
  const RasporedView({super.key});

  @override
  State<RasporedView> createState() => _RasporedViewState();
}

class _RasporedViewState extends State<RasporedView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: RasporedNotifier(
          nastavniPlanNotifier: Provider.of<NastavniPlanNotifier>(context),
          terminiNotifier: Provider.of<TerminiNotifier>(context),
          ucioniceNotifier: Provider.of<UcioniceNotifier>(context),
        )),
      ],
      child: const RasporedWidget(),
    );
  }
}

const _rowHeight = 110.0;

class RasporedWidget extends StatefulWidget {
  const RasporedWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RasporedWidget> createState() => _RasporedWidgetState();
}

class _RasporedWidgetState extends State<RasporedWidget> {
  List<Color> colors = [
    const Color(0xffff6666),
    const Color(0xffffb266),
    const Color(0xff660066),
    const Color(0xffffff66),
    const Color(0xff66ff66),
    const Color(0xff000066),
    const Color(0xff66b2ff),
    const Color(0xffff66b2),
    const Color(0xffb2ff66),
    const Color(0xff660000),
    const Color(0xff6666ff),
    const Color(0xff66ffb2),
    const Color(0xffff66ff),
    const Color(0xff006600),
    const Color(0xff66ffff),
    const Color(0xffb266ff),
    const Color(0xff000066),
    const Color(0xff666600),
  ];

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
                Consumer<RasporedNotifier>(
                    builder: (context, rasporedNotifier, child) {
                  return Expanded(
                    flex: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: rasporedNotifier.raspored.isEmpty
                          ? []
                          : [
                              ...RasporedType.values
                                  .map((type) => Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Radio<RasporedType>(
                                              value: type,
                                              groupValue:
                                                  rasporedNotifier.rasporedType,
                                              onChanged: (val) {
                                                if (val != null) {
                                                  rasporedNotifier
                                                      .setRasporedType(val);
                                                }
                                              }),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(rasporedTypeMappedToBosanski[
                                              type]!),
                                        ],
                                      ))
                                  .toList(),
                              if (rasporedNotifier.rasporedType ==
                                  RasporedType.grupa)
                                Consumer<GrupeNotifier>(
                                    builder: (context, grupeNotifier, child) {
                                  if (grupeNotifier.grupeMapped.isNotEmpty) {
                                    return SizedBox(
                                      width: 240,
                                      child: DropdownButtonFormField(
                                          isExpanded: true,
                                          value: rasporedNotifier.selectedGrupa,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide:
                                                    const BorderSide(width: 0),
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                              filled: true,
                                              fillColor: const Color.fromRGBO(
                                                  9, 30, 66, 0.04)),
                                          hint: const Text('Odabir odjeljenja',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              )),
                                          items: rasporedNotifier.grupe
                                              .map(
                                                (grupa) => DropdownMenuItem(
                                                  value: grupa,
                                                  child: Text(
                                                    grupeNotifier
                                                        .grupeMapped[grupa]!
                                                        .naslov,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (value) => rasporedNotifier
                                              .setSelectedGrupa(value)),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                }),
                              if (rasporedNotifier.rasporedType ==
                                  RasporedType.ucionica)
                                Consumer<PredmetiNotifier>(builder:
                                    (context, predmetiNotifier, child) {
                                  if (predmetiNotifier
                                      .predmetiMapped.isNotEmpty) {
                                    return SizedBox(
                                      width: 240,
                                      child: DropdownButtonFormField(
                                          isExpanded: true,
                                          value:
                                              rasporedNotifier.selectedUcionica,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide:
                                                    const BorderSide(width: 0),
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                              filled: true,
                                              fillColor: const Color.fromRGBO(
                                                  9, 30, 66, 0.04)),
                                          hint: const Text('Odabir učionice',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              )),
                                          items: rasporedNotifier.ucionice
                                              .map(
                                                (ucionica) => DropdownMenuItem(
                                                  value: ucionica,
                                                  child: Text(
                                                    ucionica.naslov,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (value) => rasporedNotifier
                                              .setSelectedUcionica(value)),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                }),
                              if (rasporedNotifier.rasporedType ==
                                  RasporedType.nastavnik)
                                Consumer<NastavniciNotifier>(builder:
                                    (context, nastavniciNotifier, child) {
                                  if (nastavniciNotifier
                                      .nastavniciMapped.isNotEmpty) {
                                    return SizedBox(
                                      width: 240,
                                      child: DropdownButtonFormField(
                                          isExpanded: true,
                                          value: rasporedNotifier
                                              .selectedNastavnik,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide:
                                                    const BorderSide(width: 0),
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                              filled: true,
                                              fillColor: const Color.fromRGBO(
                                                  9, 30, 66, 0.04)),
                                          hint: const Text('Odabir profesora',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              )),
                                          items: rasporedNotifier.nastavnici
                                              .map(
                                                (nastavnik) => DropdownMenuItem(
                                                  value: nastavnik,
                                                  child: Text(
                                                    nastavniciNotifier
                                                        .nastavniciMapped[
                                                            nastavnik]!
                                                        .naslov,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (value) => rasporedNotifier
                                              .setSelectedNastavnik(value)),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                }),
                            ],
                    ),
                  );
                }),
                const SizedBox(width: 30),
                Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () async {
                        ReusableLoader.showLoader(context, withText: true);
                        await Provider.of<RasporedNotifier>(context,
                                listen: false)
                            .createRaspored();
                        ReusableLoader.popLoader();
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
                                'Generiši',
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
        Consumer<PredmetiNotifier>(builder: (context, predmetiNotifier, child) {
          return Consumer<GrupeNotifier>(
              builder: (context, grupeNotifier, child) {
            return Consumer<NastavniciNotifier>(
                builder: (context, nastavniciNotifier, child) {
              return Consumer<RasporedNotifier>(
                builder: (context, rasporedNotifier, child) {
                  if (rasporedNotifier.getRasporedError) {
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
                  if (rasporedNotifier.raspored.isEmpty) {
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
                                'Hmm izgleda da niste generisali raspored',
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
                  if (rasporedNotifier.rasporedType == RasporedType.grupa &&
                      rasporedNotifier.selectedGrupa == null) {
                    return const Expanded(
                        child: Center(
                            child: Text(
                      'Odaberite odjeljenje da vidite raspored!',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    )));
                  }
                  if (rasporedNotifier.rasporedType == RasporedType.ucionica &&
                      rasporedNotifier.selectedUcionica == null) {
                    return const Expanded(
                        child: Center(
                            child: Text(
                      'Odaberite učionicu da vidite raspored!',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    )));
                  }
                  if (rasporedNotifier.rasporedType == RasporedType.nastavnik &&
                      rasporedNotifier.selectedNastavnik == null) {
                    return const Expanded(
                        child: Center(
                            child: Text(
                      'Odaberite profesora da vidite raspored!',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    )));
                  }
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(50, 0, 50, 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 1, color: const Color(0xffdddddd)),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 60,
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xffdddddd))),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (ctx) {
                                            return Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              child: PdfView(
                                                rasporedType: rasporedNotifier
                                                    .rasporedType,
                                                najkasniji: rasporedNotifier
                                                    .najkasniji!,
                                                najraniji:
                                                    rasporedNotifier.najraniji!,
                                                selectedGrupa: rasporedNotifier
                                                    .selectedGrupa,
                                                selectedNastavnik:
                                                    rasporedNotifier
                                                        .selectedNastavnik,
                                                selectedUcionica:
                                                    rasporedNotifier
                                                        .selectedUcionica,
                                                mappedByGrupe: rasporedNotifier
                                                    .mappedByGrupe,
                                                mappedByNastavnici:
                                                    rasporedNotifier
                                                        .mappedByNastavnici,
                                                mappedByUcionica:
                                                    rasporedNotifier
                                                        .mappedByUcionica,
                                                grupeMapped:
                                                    grupeNotifier.grupeMapped,
                                                nastavniciMapped:
                                                    nastavniciNotifier
                                                        .nastavniciMapped,
                                                predmetiMapped: predmetiNotifier
                                                    .predmetiMapped,
                                                    grupe: rasporedNotifier.grupe,
                                                    predmeti: rasporedNotifier.predmeti,
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.mainGreen,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Text(
                                              'PDF',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ...Dan.values.map(
                                  (dan) => Expanded(
                                    child: Center(
                                      child: Text(
                                        daniMappedNaBosanski[dan]!
                                            .toUpperCase(),
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
                                      Builder(builder: (context) {
                                        List<String> sati = [];
                                        for (var i = rasporedNotifier
                                                .najraniji!.hour;
                                            i <=
                                                rasporedNotifier
                                                    .najkasniji!.hour;
                                            i++) {
                                          sati.add("$i:00");
                                        }

                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                ...sati
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
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14,
                                                                color: AppColors
                                                                    .mainGreen),
                                                          ),
                                                        ))
                                                    .toList(),
                                              ],
                                            ),
                                            Expanded(
                                              flex: 6,
                                              child: Column(
                                                children: [
                                                  ...sati
                                                      .map(
                                                        (sat) => Container(
                                                          width:
                                                              double.infinity,
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
                                        );
                                      }),
                                      Builder(builder: (context) {
                                        Map<dynamic, Color> colorsMapped = {};
                                        try {
                                          if (rasporedNotifier.rasporedType ==
                                              RasporedType.grupa) {
                                            for (var i = 0;
                                                i <
                                                    rasporedNotifier
                                                        .predmeti.length;
                                                i++) {
                                              colorsMapped[rasporedNotifier
                                                  .predmeti[i]] = colors[i];
                                            }
                                          }

                                          if (rasporedNotifier.rasporedType ==
                                              RasporedType.ucionica) {
                                            for (var i = 0;
                                                i <
                                                    rasporedNotifier
                                                        .grupe.length;
                                                i++) {
                                              colorsMapped[rasporedNotifier
                                                  .grupe[i]] = colors[i];
                                            }
                                          }

                                          if (rasporedNotifier.rasporedType ==
                                              RasporedType.nastavnik) {
                                            for (var i = 0;
                                                i <
                                                    rasporedNotifier
                                                        .grupe.length;
                                                i++) {
                                              colorsMapped[rasporedNotifier
                                                  .grupe[i]] = colors[i];
                                            }
                                          }
                                        } catch (e) {
                                          debugPrint(e.toString());
                                        }

                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: _rowHeight),
                                            ...Dan.values.map((dan) => Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      ...(rasporedNotifier
                                                                      .rasporedType ==
                                                                  RasporedType
                                                                      .grupa
                                                              ? rasporedNotifier
                                                                      .mappedByGrupe[
                                                                  rasporedNotifier
                                                                      .selectedGrupa]
                                                              : rasporedNotifier
                                                                          .rasporedType ==
                                                                      RasporedType
                                                                          .ucionica
                                                                  ? rasporedNotifier
                                                                          .mappedByUcionica[
                                                                      rasporedNotifier
                                                                          .selectedUcionica]
                                                                  : rasporedNotifier
                                                                          .mappedByNastavnici[
                                                                      rasporedNotifier
                                                                          .selectedNastavnik])![dan]!
                                                          .map((raspored) {
                                                        final DateTime now =
                                                            DateTime.now();
                                                        final DateTime start =
                                                            DateTime(
                                                                now.year,
                                                                now.month,
                                                                now.day,
                                                                (raspored
                                                                        .termin)
                                                                    .pocetak
                                                                    .hour,
                                                                (raspored
                                                                        .termin)
                                                                    .pocetak
                                                                    .minute);
                                                        final DateTime end =
                                                            DateTime(
                                                                now.year,
                                                                now.month,
                                                                now.day,
                                                                (raspored
                                                                        .termin)
                                                                    .kraj
                                                                    .hour,
                                                                (raspored
                                                                        .termin)
                                                                    .kraj
                                                                    .minute);
                                                        return Container(
                                                          width:
                                                              double.infinity,
                                                          height: end
                                                                  .difference(
                                                                      start)
                                                                  .inMinutes /
                                                              60 *
                                                              _rowHeight,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration: !raspored
                                                                  .termin.show!
                                                              ? null
                                                              : BoxDecoration(
                                                                  color: raspored
                                                                          .termin
                                                                          .show!
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .transparent,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  border: Border.all(
                                                                      width: 1,
                                                                      color: const Color(
                                                                          0xffe7e7e7))),
                                                          child:
                                                              !raspored.termin
                                                                      .show!
                                                                  ? null
                                                                  : Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        if (rasporedNotifier.rasporedType ==
                                                                            RasporedType.ucionica) ...[
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                grupeNotifier.grupeMapped[raspored.grupaId]!.naslov,
                                                                                style: const TextStyle(
                                                                                  fontWeight: FontWeight.w700,
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                              const Spacer(),
                                                                              Text(
                                                                                '${timeOfDayToString(raspored.termin.pocetak)} - ${timeOfDayToString(raspored.termin.kraj)}',
                                                                                style: const TextStyle(
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 12,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Text(
                                                                            nastavniciNotifier.nastavniciMapped[raspored.nastavnikId]!.naslov,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            predmetiNotifier.predmetiMapped[raspored.predmetId]!.naslov,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                5,
                                                                            width:
                                                                                double.infinity,
                                                                            color:
                                                                                colorsMapped[raspored.grupaId],
                                                                          ),
                                                                        ],
                                                                        if (rasporedNotifier.rasporedType ==
                                                                            RasporedType.grupa) ...[
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                predmetiNotifier.predmetiMapped[raspored.predmetId]!.naslov,
                                                                                style: const TextStyle(
                                                                                  fontWeight: FontWeight.w700,
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                              const Spacer(),
                                                                              Text(
                                                                                '${timeOfDayToString(raspored.termin.pocetak)} - ${timeOfDayToString(raspored.termin.kraj)}',
                                                                                style: const TextStyle(
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 12,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Text(
                                                                            nastavniciNotifier.nastavniciMapped[raspored.nastavnikId]!.naslov,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            raspored.ucionica.naslov,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                5,
                                                                            width:
                                                                                double.infinity,
                                                                            color:
                                                                                colorsMapped[raspored.predmetId],
                                                                          ),
                                                                        ],
                                                                        if (rasporedNotifier.rasporedType ==
                                                                            RasporedType.nastavnik) ...[
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                grupeNotifier.grupeMapped[raspored.grupaId]!.naslov,
                                                                                style: const TextStyle(
                                                                                  fontWeight: FontWeight.w700,
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                              const Spacer(),
                                                                              Text(
                                                                                '${timeOfDayToString(raspored.termin.pocetak)} - ${timeOfDayToString(raspored.termin.kraj)}',
                                                                                style: const TextStyle(
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 12,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Text(
                                                                            predmetiNotifier.predmetiMapped[raspored.predmetId]!.naslov,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            raspored.ucionica.naslov,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                5,
                                                                            width:
                                                                                double.infinity,
                                                                            color:
                                                                                colorsMapped[raspored.grupaId],
                                                                          ),
                                                                        ],
                                                                      ],
                                                                    ),
                                                        );
                                                      }).toList(),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        );
                                      }),
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
              );
            });
          });
        }),
      ],
    );
  }
}
