import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/providers/grupe_notifier.dart';
import 'package:web_app_timetable/shared/theme/colors.dart';

import '../../shared/widgets/loader.dart';

class GrupeView extends StatefulWidget {
  const GrupeView({super.key});

  @override
  State<GrupeView> createState() => _GrupeViewState();
}

class _GrupeViewState extends State<GrupeView> {
  @override
  void initState() {
    super.initState();
    Provider.of<GrupeNotifier>(context, listen: false).getGrupeLoading = true;
    Provider.of<GrupeNotifier>(context, listen: false).getGrupeError = false;
    Provider.of<GrupeNotifier>(context, listen: false).getGrupe();
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
                        Provider.of<GrupeNotifier>(context, listen: false)
                            .filterGrupe(filter),
                  ),
                ),
                const SizedBox(width: 15),
                Consumer<GrupeNotifier>(
                  builder: (context, grupeNotifier, child) {
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
                            value: grupeNotifier.grupeSort,
                            items: GrupeSort.values
                                .map(
                                  (sort) => DropdownMenuItem(
                                    value: sort,
                                    child: Text(
                                      grupeSort[sort],
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
                                grupeNotifier.setGrupeSort(value);
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
                        Provider.of<GrupeNotifier>(context, listen: false)
                            .setOdjeljenjeDialog(null, notify: false);
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Consumer<GrupeNotifier>(
                              builder: (context, grupeNotifier, child) {
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
                                            'Dodaj odjeljenje',
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
                                        'Unesite naziv odjeljena kojeg želite dodati',
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
                                          hintText: 'Naziv odjeljenja',
                                          hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                        onChanged: (value) => grupeNotifier
                                            .setOdjeljenjeDialog(value),
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
                                              onTap: grupeNotifier
                                                          .odjeljenjeDialog !=
                                                      null
                                                  ? () async {
                                                      ReusableLoader.showLoader(
                                                          context);

                                                      await grupeNotifier
                                                          .addGrupa();

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
                                                  color: grupeNotifier
                                                              .odjeljenjeDialog !=
                                                          null
                                                      ? AppColors.mainGreen
                                                      : const Color(0xff8d8d8d),
                                                ),
                                                height: 50,
                                                child: const Center(
                                                  child: Text(
                                                    'Dodaj odjeljenje',
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
                                'Dodaj novo odjeljenje',
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
        Consumer<GrupeNotifier>(
          builder: (context, grupeNotifier, child) {
            if (grupeNotifier.getGrupeLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (grupeNotifier.getGrupeError) {
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
            if (grupeNotifier.grupe.isEmpty && !grupeNotifier.grupeFiltered) {
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
                          'Hmm izgleda da niste dodali odjeljenja',
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
            if (grupeNotifier.grupe.isEmpty && grupeNotifier.grupeFiltered) {
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
                  children: grupeNotifier.grupe
                      .map((grupa) => Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Text(
                                  grupa.naslov,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                /*InkWell(
                                  onTap: () {
                                    Provider.of<GrupeNotifier>(context,
                                            listen: false)
                                        .setOdjeljenjeDialog(grupa.naslov,
                                            notify: false);
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Consumer<GrupeNotifier>(
                                          builder:
                                              (context, grupeNotifier, child) {
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
                                                        'Izmjeni odjeljenje',
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
                                                    'Izmjenite naziv odjeljena',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 40),
                                                  const SizedBox(height: 22),
                                                  TextFormField(
                                                    initialValue: grupa.naslov,
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
                                                          'Naziv odjeljenja',
                                                      hintStyle:
                                                          const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    onChanged: (value) =>
                                                        grupeNotifier
                                                            .setOdjeljenjeDialog(
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
                                                          onTap: grupeNotifier
                                                                      .odjeljenjeDialog !=
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
                                                              color: grupeNotifier
                                                                          .odjeljenjeDialog !=
                                                                      null
                                                                  ? AppColors
                                                                      .mainGreen
                                                                  : const Color(
                                                                      0xff8d8d8d),
                                                            ),
                                                            height: 50,
                                                            child: const Center(
                                                              child: Text(
                                                                'Izmjeni odjeljenje',
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
                                    grupeNotifier.removeGrupe(grupa.id);
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
