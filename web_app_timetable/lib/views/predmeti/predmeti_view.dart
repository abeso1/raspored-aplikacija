import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/providers/predmeti_notifier.dart';
import 'package:web_app_timetable/shared/theme/colors.dart';

import '../../shared/widgets/loader.dart';

class PredmetiView extends StatefulWidget {
  const PredmetiView({super.key});

  @override
  State<PredmetiView> createState() => _PredmetiViewState();
}

class _PredmetiViewState extends State<PredmetiView> {
  @override
  void initState() {
    super.initState();
    Provider.of<PredmetiNotifier>(context, listen: false).getPredmetiLoading =
        true;
    Provider.of<PredmetiNotifier>(context, listen: false).getPredmetiError =
        false;
    Provider.of<PredmetiNotifier>(context, listen: false).getPredmeti();
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
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              const BorderSide(color: Color(0xffefefef))),
                      fillColor: const Color(0xfff2f3f5),
                      filled: true,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                      hintText: 'Pretraživanje...',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    onChanged: (filter) =>
                        Provider.of<PredmetiNotifier>(context, listen: false)
                            .filterPredmeti(filter),
                  ),
                ),
                const SizedBox(width: 15),
                Consumer<PredmetiNotifier>(
                  builder: (context, predmetiNotifier, child) {
                    return Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(9, 30, 66, 0.04),
                            borderRadius: BorderRadius.circular(3)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            focusColor: Colors.transparent,
                            value: predmetiNotifier.predmetiSort,
                            items: PredmetiSort.values
                                .map(
                                  (sort) => DropdownMenuItem(
                                    value: sort,
                                    child: Text(
                                      predmetiSort[sort],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                predmetiNotifier.setPredmetiSort(value);
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 15),
                Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () {
                        Provider.of<PredmetiNotifier>(context, listen: false)
                            .setPredmetDialog(null, notify: false);
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Consumer<PredmetiNotifier>(
                              builder: (context, predmetiNotifier, child) {
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
                                            'Dodaj predmet',
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
                                        'Unesite naziv predmeta kojeg želite dodati',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      const SizedBox(height: 22),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          filled: true,
                                          fillColor: const Color.fromRGBO(
                                              9, 30, 66, 0.04),
                                          hintText: 'Naziv predmeta',
                                          hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                        onChanged: (value) => predmetiNotifier
                                            .setPredmetDialog(value),
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
                                              onTap: predmetiNotifier
                                                          .predmetDialog !=
                                                      null
                                                  ? () async {
                                                      ReusableLoader.showLoader(
                                                          context);
                                                      await predmetiNotifier
                                                          .addPredmet();
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
                                                  color: predmetiNotifier
                                                              .predmetDialog !=
                                                          null
                                                      ? AppColors.mainGreen
                                                      : const Color(0xff8d8d8d),
                                                ),
                                                height: 50,
                                                child: const Center(
                                                  child: Text(
                                                    'Dodaj predmet',
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
                                'Dodaj novi predmet',
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
        Consumer<PredmetiNotifier>(
          builder: (context, predmetiNotifier, child) {
            if (predmetiNotifier.getPredmetiLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (predmetiNotifier.getPredmetiError) {
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
            if (predmetiNotifier.predmeti.isEmpty &&
                !predmetiNotifier.predmetiFiltered) {
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
                          'Hmm izgleda da niste dodali predmete',
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
            if (predmetiNotifier.predmeti.isEmpty &&
                predmetiNotifier.predmetiFiltered) {
              return const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Lista je prazna!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
            return Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: predmetiNotifier.predmeti
                      .map((predmet) => Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Text(
                                  predmet.naslov,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                /*InkWell(
                                  onTap: () {
                                    Provider.of<PredmetiNotifier>(context,
                                            listen: false)
                                        .setPredmetDialog(predmet.naslov,
                                            notify: false);
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Consumer<PredmetiNotifier>(
                                          builder: (context, predmetiNotifier,
                                              child) {
                                            return Container(
                                              width: 800,
                                              height: 600,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 80,
                                                      vertical: 60),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Izmjeni predmet',
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
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
                                                    'Izmjeni naziv predmeta',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 40),
                                                  const SizedBox(height: 22),
                                                  TextFormField(
                                                    initialValue:
                                                        predmet.naslov,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          const Color.fromRGBO(
                                                              9, 30, 66, 0.04),
                                                      hintText:
                                                          'Naziv predmeta',
                                                      hintStyle:
                                                          const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    onChanged: (value) =>
                                                        predmetiNotifier
                                                            .setPredmetDialog(
                                                                value),
                                                  ),
                                                  const Spacer(),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Expanded(
                                                        flex: 2,
                                                        child: InkWell(
                                                          onTap: predmetiNotifier
                                                                      .predmetDialog !=
                                                                  null
                                                              ? () async {
                                                                  ReusableLoader
                                                                      .showLoader(
                                                                          context);

                                                                  ReusableLoader
                                                                      .popLoader();
                                                                  // ignore: use_build_context_synchronously
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }
                                                              : null,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3),
                                                              color: predmetiNotifier
                                                                          .predmetDialog !=
                                                                      null
                                                                  ? AppColors
                                                                      .mainGreen
                                                                  : const Color(
                                                                      0xff8d8d8d),
                                                            ),
                                                            height: 50,
                                                            child: const Center(
                                                              child: Text(
                                                                'Izmjeni predmet',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white,
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
                                  child: const Icon(
                                    Icons.edit,
                                    color: Color(0xff4b4b4b),
                                  ),
                                ),*/
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    predmetiNotifier.removePredmet(predmet.id);
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Color(0xff4b4b4b),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
