import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/providers/add_nastavni_plan_notifier.dart';
import 'package:web_app_timetable/providers/grupe_notifier.dart';
import 'package:web_app_timetable/providers/nastavnici_notifier.dart';
import 'package:web_app_timetable/providers/predmeti_notifier.dart';
import 'package:web_app_timetable/shared/theme/colors.dart';
import 'package:web_app_timetable/shared/widgets/loader.dart';
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
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Consumer<AddNastavniPlanNotifier>(
                            builder: (context, addNastavniPlanNotifier, child) {
                              return Container(
                                width: 800,
                                height: 600,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80, vertical: 60),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Dodaj nastavni plan',
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
                                    Consumer<NastavniciNotifier>(builder:
                                        (context, nastavniciNotifier, child) {
                                      return DropdownButtonFormField(
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
                                          items: nastavniciNotifier
                                              .unfilteredNastavnici
                                              .map(
                                                (nastavnik) => DropdownMenuItem(
                                                  value: nastavnik.id,
                                                  child: Text(
                                                    nastavnik.naslov,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (value) =>
                                              addNastavniPlanNotifier
                                                  .setNastavnikId(value));
                                    }),
                                    const SizedBox(height: 10),
                                    Consumer<PredmetiNotifier>(builder:
                                        (context, predmetiNotifier, child) {
                                      return DropdownButtonFormField(
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
                                          hint: const Text('Odabir predmeta',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              )),
                                          items: predmetiNotifier
                                              .unfilteredPredmeti
                                              .map(
                                                (predmet) => DropdownMenuItem(
                                                  value: predmet.id,
                                                  child: Text(
                                                    predmet.naslov,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (value) =>
                                              addNastavniPlanNotifier
                                                  .setPredmetId(value));
                                    }),
                                    const SizedBox(height: 10),
                                    Consumer<GrupeNotifier>(builder:
                                        (context, grupeNotifier, child) {
                                      return DropdownButtonFormField(
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
                                          items: grupeNotifier.unfilteredGrupe
                                              .map(
                                                (predmet) => DropdownMenuItem(
                                                  value: predmet.id,
                                                  child: Text(
                                                    predmet.naslov,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (value) =>
                                              addNastavniPlanNotifier
                                                  .setGrupaId(value));
                                    }),
                                    const SizedBox(height: 22),
                                    TextFormField(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        filled: true,
                                        fillColor: const Color.fromRGBO(
                                            9, 30, 66, 0.04),
                                        hintText:
                                            'Unesite broj sedmičnih časova',
                                        hintStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      onChanged: (value) =>
                                          addNastavniPlanNotifier.setBrojCasova(
                                              int.tryParse(value)),
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
                                            onTap:
                                                addNastavniPlanNotifier
                                                                .brojCasova !=
                                                            null &&
                                                        addNastavniPlanNotifier
                                                                .grupaId !=
                                                            null &&
                                                        addNastavniPlanNotifier
                                                                .predmetId !=
                                                            null &&
                                                        addNastavniPlanNotifier
                                                                .nastavnikId !=
                                                            null
                                                    ? () async {
                                                        ReusableLoader
                                                            .showLoader(
                                                                context);
                                                        await addNastavniPlanNotifier
                                                            .addNastavniPlan();
                                                        // ignore: use_build_context_synchronously
                                                        Provider.of<NastavniPlanNotifier>(
                                                                context,
                                                                listen: false)
                                                            .getNastavniPlan();
                                                        ReusableLoader
                                                            .popLoader();
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    : null,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color:
                                                    addNastavniPlanNotifier
                                                                    .brojCasova !=
                                                                null &&
                                                            addNastavniPlanNotifier
                                                                    .grupaId !=
                                                                null &&
                                                            addNastavniPlanNotifier
                                                                    .predmetId !=
                                                                null &&
                                                            addNastavniPlanNotifier
                                                                    .nastavnikId !=
                                                                null
                                                        ? AppColors.mainGreen
                                                        : const Color(
                                                            0xff8d8d8d),
                                              ),
                                              height: 50,
                                              child: const Center(
                                                child: Text(
                                                  'Dodaj nastavni plan',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
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
                              'Dodaj novi plan',
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
        Consumer<GrupeNotifier>(builder: (context, grupeNotifier, child) {
          return Consumer<PredmetiNotifier>(
              builder: (context, predmetiNotifier, child) {
            return Consumer<NastavniciNotifier>(
                builder: (context, nastavniciNotifier, child) {
              return Consumer<NastavniPlanNotifier>(
                  builder: (context, nastavniPlanNotifier, child) {
                if (nastavniPlanNotifier.getNastavniPlanLoading ||
                    predmetiNotifier.getPredmetiLoading ||
                    grupeNotifier.getGrupeLoading ||
                    nastavniciNotifier.getNastavniciLoading) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (nastavniPlanNotifier.getNastavniPlanError ||
                    predmetiNotifier.getPredmetiError ||
                    grupeNotifier.getGrupeError ||
                    nastavniciNotifier.getNastavniciError) {
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
                                'Predmet',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Profesor',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Odjeljenje',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Broj sati sedmično',
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
                            children: nastavniPlanNotifier.nastavniPlan
                                .map((plan) => Container(
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              nastavniciNotifier
                                                      .nastavniciMapped[
                                                          plan.nastavnikId]
                                                      ?.naslov ??
                                                  '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              predmetiNotifier
                                                      .predmetiMapped[
                                                          plan.predmetId]
                                                      ?.naslov ??
                                                  '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              grupeNotifier
                                                      .grupeMapped[plan.grupaId]
                                                      ?.naslov ??
                                                  '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              plan.brojCasova.toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: const [
                                                Spacer(),
                                                Icon(
                                                  Icons.delete,
                                                  color: Color(0xff4b4b4b),
                                                ),
                                                SizedBox(width: 16),
                                                Icon(
                                                  Icons.edit,
                                                  color: Color(0xff4b4b4b),
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
              });
            });
          });
        }),
      ],
    );
  }
}
