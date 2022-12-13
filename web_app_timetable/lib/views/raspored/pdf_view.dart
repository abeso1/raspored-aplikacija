import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:web_app_timetable/models/nastavnik/nastavnik.dart';
import 'package:web_app_timetable/models/predmet/predmet.dart';
import 'package:web_app_timetable/models/predmet/predmet_id.dart';

import '../../models/grupa/grupa.dart';
import '../../models/grupa/grupa_id.dart';
import '../../models/nastavnik/nastavnik_id.dart';
import '../../models/raspored/raspored.dart';
import '../../models/termin/dan.dart';
import '../../models/termin/termin.dart';
import '../../models/ucionica/ucionica.dart';
import '../../providers/raspored_notifier.dart';

import 'package:printing/printing.dart';
import 'dart:html' as html;

class PdfView {
  Future<void> generateReport({
    required final RasporedType rasporedType,
    required final TimeOfDay najraniji,
    required final TimeOfDay najkasniji,
    required final GrupaId? selectedGrupa,
    required final NastavnikId? selectedNastavnik,
    required final Ucionica? selectedUcionica,
    required final Map<Ucionica, Map<Dan, List<Raspored>>> mappedByUcionica,
    required final Map<NastavnikId, Map<Dan, List<Raspored>>>
        mappedByNastavnici,
    required final Map<GrupaId, Map<Dan, List<Raspored>>> mappedByGrupe,
    required final Map<GrupaId, Grupa> grupeMapped,
    required final Map<PredmetId, Predmet> predmetiMapped,
    required final Map<NastavnikId, Nastavnik> nastavniciMapped,
    required final List<GrupaId> grupe,
    required final List<PredmetId> predmeti,
  }) async {
    List<PdfColor> colors = [
      const PdfColor.fromInt(0xffff6666),
      const PdfColor.fromInt(0xffffb266),
      const PdfColor.fromInt(0xff660066),
      const PdfColor.fromInt(0xffffff66),
      const PdfColor.fromInt(0xff66ff66),
      const PdfColor.fromInt(0xff000066),
      const PdfColor.fromInt(0xff66b2ff),
      const PdfColor.fromInt(0xffff66b2),
      const PdfColor.fromInt(0xffb2ff66),
      const PdfColor.fromInt(0xff660000),
      const PdfColor.fromInt(0xff6666ff),
      const PdfColor.fromInt(0xff66ffb2),
      const PdfColor.fromInt(0xffff66ff),
      const PdfColor.fromInt(0xff006600),
      const PdfColor.fromInt(0xff66ffff),
      const PdfColor.fromInt(0xffb266ff),
      const PdfColor.fromInt(0xff000066),
      const PdfColor.fromInt(0xff666600),
    ];

    PdfColor mainGreen = const PdfColor.fromInt(0xff119c59);
    const rowHeight = 70.0;

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansRegular();
    final doc = pw.Document(
      pageMode: PdfPageMode.outlines,
    )..addPage(
        pw.MultiPage(
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
          header: (final context) => pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(width: 0.5, color: PdfColors.grey),
              ),
            ),
            child: pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Raspored',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      rasporedType == RasporedType.grupa
                          ? grupeMapped[selectedGrupa]!.naslov
                          : rasporedType == RasporedType.nastavnik
                              ? nastavniciMapped[selectedNastavnik]!.naslov
                              : selectedUcionica!.naslov,
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      DateFormat('dd.MM.yyyy.').format(DateTime.now()),
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          orientation: pw.PageOrientation.landscape,
          margin: const pw.EdgeInsets.fromLTRB(20, 20, 20, 0),
          build: (final context) => [
            pw.Container(
              height: PdfPageFormat.a4.availableWidth,
              child: pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      color: PdfColors.white,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            padding:
                                const pw.EdgeInsets.symmetric(horizontal: 20),
                            height: 60,
                            decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                  bottom: pw.BorderSide(
                                      width: 1,
                                      color: PdfColor.fromInt(0xffdddddd))),
                            ),
                            child: pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.SizedBox(
                                  width: 50,
                                ),
                                ...Dan.values.map(
                                  (dan) => pw.Expanded(
                                    child: pw.Center(
                                      child: pw.Text(
                                        daniMappedNaBosanski[dan]!
                                            .toUpperCase(),
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 9,
                                            color: mainGreen),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                pw.Stack(
                                  children: [
                                    pw.Builder(builder: (context) {
                                      List<String> sati = [];
                                      for (var i = najraniji.hour;
                                          i <= najkasniji.hour;
                                          i++) {
                                        sati.add("$i:00");
                                      }

                                      return pw.Row(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Column(
                                            children: [
                                              ...sati
                                                  .map((sat) => pw.Container(
                                                        width: 50,
                                                        height: rowHeight,
                                                        decoration: const pw
                                                            .BoxDecoration(
                                                          border: pw.Border(
                                                            top: pw.BorderSide(
                                                                width: 1,
                                                                color: PdfColor
                                                                    .fromInt(
                                                                        0xffe7e7e7)),
                                                          ),
                                                        ),
                                                        child: pw.Text(
                                                          sat,
                                                          style: pw.TextStyle(
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                              fontSize: 9,
                                                              color: mainGreen),
                                                        ),
                                                      ))
                                                  .toList(),
                                            ],
                                          ),
                                          pw.Expanded(
                                            flex: 6,
                                            child: pw.Column(
                                              children: [
                                                ...sati
                                                    .map(
                                                      (sat) => pw.Container(
                                                        width: double.infinity,
                                                        height: rowHeight,
                                                        decoration: const pw
                                                            .BoxDecoration(
                                                          border: pw.Border(
                                                            top: pw.BorderSide(
                                                                width: 1,
                                                                color: PdfColor
                                                                    .fromInt(
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
                                    pw.Builder(builder: (context) {
                                      Map<dynamic, PdfColor> colorsMapped = {};
                                      try {
                                        if (rasporedType ==
                                            RasporedType.grupa) {
                                          for (var i = 0;
                                              i < predmeti.length;
                                              i++) {
                                            colorsMapped[predmeti[i]] =
                                                colors[i];
                                          }
                                        }

                                        if (rasporedType ==
                                            RasporedType.ucionica) {
                                          for (var i = 0;
                                              i < grupe.length;
                                              i++) {
                                            colorsMapped[grupe[i]] = colors[i];
                                          }
                                        }

                                        if (rasporedType ==
                                            RasporedType.nastavnik) {
                                          for (var i = 0;
                                              i < grupe.length;
                                              i++) {
                                            colorsMapped[grupe[i]] = colors[i];
                                          }
                                        }
                                      } catch (e) {
                                        debugPrint(e.toString());
                                      }

                                      return pw.Row(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        children: [
                                          pw.SizedBox(width: 70),
                                          ...Dan.values.map(
                                            (dan) => pw.Expanded(
                                              child: pw.Column(
                                                crossAxisAlignment:
                                                    pw.CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  ...(rasporedType ==
                                                              RasporedType.grupa
                                                          ? mappedByGrupe[
                                                              selectedGrupa]
                                                          : rasporedType ==
                                                                  RasporedType
                                                                      .ucionica
                                                              ? mappedByUcionica[
                                                                  selectedUcionica]
                                                              : mappedByNastavnici[
                                                                  selectedNastavnik])![dan]!
                                                      .map((raspored) {
                                                    final DateTime now =
                                                        DateTime.now();
                                                    final DateTime start =
                                                        DateTime(
                                                            now.year,
                                                            now.month,
                                                            now.day,
                                                            (raspored.termin)
                                                                .pocetak
                                                                .hour,
                                                            (raspored.termin)
                                                                .pocetak
                                                                .minute);
                                                    final DateTime end =
                                                        DateTime(
                                                            now.year,
                                                            now.month,
                                                            now.day,
                                                            (raspored.termin)
                                                                .kraj
                                                                .hour,
                                                            (raspored.termin)
                                                                .kraj
                                                                .minute);
                                                    return pw.Container(
                                                      width: double.infinity,
                                                      height: end
                                                              .difference(start)
                                                              .inMinutes /
                                                          60 *
                                                          rowHeight,
                                                      margin: const pw
                                                              .EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                      padding: const pw
                                                          .EdgeInsets.all(3),
                                                      decoration: !raspored
                                                              .termin.show!
                                                          ? null
                                                          : pw.BoxDecoration(
                                                              color: raspored
                                                                      .termin
                                                                      .show!
                                                                  ? PdfColors
                                                                      .white
                                                                  : null,
                                                              borderRadius:
                                                                  pw.BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border: pw.Border.all(
                                                                  width: 1,
                                                                  color: const PdfColor.fromInt(
                                                                      0xffe7e7e7))),
                                                      child:
                                                          !raspored.termin.show!
                                                              ? null
                                                              : pw.Column(
                                                                  crossAxisAlignment: pw
                                                                      .CrossAxisAlignment
                                                                      .start,
                                                                  mainAxisAlignment: pw
                                                                      .MainAxisAlignment
                                                                      .spaceEvenly,
                                                                  children: [
                                                                    if (rasporedType ==
                                                                        RasporedType
                                                                            .ucionica) ...[
                                                                      pw.Row(
                                                                        children: [
                                                                          pw.Text(
                                                                            grupeMapped[raspored.grupaId]!.naslov,
                                                                            style:
                                                                                pw.TextStyle(
                                                                              fontWeight: pw.FontWeight.bold,
                                                                              fontSize: 7,
                                                                            ),
                                                                          ),
                                                                          pw.Spacer(),
                                                                          pw.Text(
                                                                            '${timeOfDayToString(raspored.termin.pocetak)} - ${timeOfDayToString(raspored.termin.kraj)}',
                                                                            style:
                                                                                pw.TextStyle(
                                                                              fontWeight: pw.FontWeight.bold,
                                                                              fontSize: 7,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      pw.Text(
                                                                        nastavniciMapped[raspored.nastavnikId]!
                                                                            .naslov,
                                                                        style: pw
                                                                            .TextStyle(
                                                                          fontWeight: pw
                                                                              .FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              7,
                                                                        ),
                                                                      ),
                                                                      pw.Text(
                                                                        predmetiMapped[raspored.predmetId]!
                                                                            .naslov,
                                                                        style: pw
                                                                            .TextStyle(
                                                                          fontWeight: pw
                                                                              .FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              7,
                                                                        ),
                                                                      ),
                                                                      pw.Container(
                                                                        height:
                                                                            5,
                                                                        width: double
                                                                            .infinity,
                                                                        decoration: pw.BoxDecoration(
                                                                            color:
                                                                                colorsMapped[raspored.grupaId],
                                                                            borderRadius: pw.BorderRadius.circular(2.5)),
                                                                      ),
                                                                    ],
                                                                    if (rasporedType ==
                                                                        RasporedType
                                                                            .grupa) ...[
                                                                      pw.Row(
                                                                        children: [
                                                                          pw.Text(
                                                                            predmetiMapped[raspored.predmetId]!.naslov,
                                                                            style:
                                                                                pw.TextStyle(
                                                                              fontWeight: pw.FontWeight.bold,
                                                                              fontSize: 7,
                                                                            ),
                                                                          ),
                                                                          pw.Spacer(),
                                                                          pw.Text(
                                                                            '${timeOfDayToString(raspored.termin.pocetak)} - ${timeOfDayToString(raspored.termin.kraj)}',
                                                                            style:
                                                                                pw.TextStyle(
                                                                              fontWeight: pw.FontWeight.bold,
                                                                              fontSize: 7,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      pw.Text(
                                                                        nastavniciMapped[raspored.nastavnikId]!
                                                                            .naslov,
                                                                        style: pw
                                                                            .TextStyle(
                                                                          fontWeight: pw
                                                                              .FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              7,
                                                                        ),
                                                                      ),
                                                                      pw.Text(
                                                                        raspored
                                                                            .ucionica
                                                                            .naslov,
                                                                        style: pw
                                                                            .TextStyle(
                                                                          fontWeight: pw
                                                                              .FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              7,
                                                                        ),
                                                                      ),
                                                                      pw.Container(
                                                                        height:
                                                                            5,
                                                                        decoration: pw.BoxDecoration(
                                                                            color:
                                                                                colorsMapped[raspored.predmetId],
                                                                            borderRadius: pw.BorderRadius.circular(2.5)),
                                                                        width: double
                                                                            .infinity,
                                                                      ),
                                                                    ],
                                                                    if (rasporedType ==
                                                                        RasporedType
                                                                            .nastavnik) ...[
                                                                      pw.Row(
                                                                        children: [
                                                                          pw.Text(
                                                                            grupeMapped[raspored.grupaId]!.naslov,
                                                                            style:
                                                                                pw.TextStyle(
                                                                              fontWeight: pw.FontWeight.bold,
                                                                              fontSize: 7,
                                                                            ),
                                                                          ),
                                                                          pw.Spacer(),
                                                                          pw.Text(
                                                                            '${timeOfDayToString(raspored.termin.pocetak)} - ${timeOfDayToString(raspored.termin.kraj)}',
                                                                            style:
                                                                                pw.TextStyle(
                                                                              fontWeight: pw.FontWeight.bold,
                                                                              fontSize: 7,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      pw.Text(
                                                                        predmetiMapped[raspored.predmetId]!
                                                                            .naslov,
                                                                        style: pw
                                                                            .TextStyle(
                                                                          fontWeight: pw
                                                                              .FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              7,
                                                                        ),
                                                                      ),
                                                                      pw.Text(
                                                                        raspored
                                                                            .ucionica
                                                                            .naslov,
                                                                        style: pw
                                                                            .TextStyle(
                                                                          fontWeight: pw
                                                                              .FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              7,
                                                                        ),
                                                                      ),
                                                                      pw.Container(
                                                                        height:
                                                                            5,
                                                                        width: double
                                                                            .infinity,
                                                                        decoration: pw.BoxDecoration(
                                                                            color:
                                                                                colorsMapped[raspored.grupaId],
                                                                            borderRadius: pw.BorderRadius.circular(2.5)),
                                                                      ),
                                                                    ],
                                                                  ],
                                                                ),
                                                    );
                                                  }).toList(),
                                                ],
                                              ),
                                            ),
                                          ),
                                          pw.SizedBox(width: 20),
                                        ],
                                      );
                                    }),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    final bytes = await doc.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');
    html.Url.revokeObjectUrl(url);
  }
}
