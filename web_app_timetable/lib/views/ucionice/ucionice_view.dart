import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/providers/ucionice_notifier.dart';
import 'package:web_app_timetable/shared/theme/colors.dart';

class UcioniceView extends StatefulWidget {
  const UcioniceView({super.key});

  @override
  State<UcioniceView> createState() => _UcioniceViewState();
}

class _UcioniceViewState extends State<UcioniceView> {
  @override
  void initState() {
    super.initState();
    Provider.of<UcioniceNotifier>(context, listen: false).getUcioniceLoading =
        true;
    Provider.of<UcioniceNotifier>(context, listen: false).getUcioniceError =
        false;
    Provider.of<UcioniceNotifier>(context, listen: false).getUcionice();
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
                        Provider.of<UcioniceNotifier>(context, listen: false)
                            .filterUcionice(filter),
                  ),
                ),
                const SizedBox(width: 15),
                Consumer<UcioniceNotifier>(
                  builder: (context, ucioniceNotifier, child) {
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
                            value: ucioniceNotifier.ucioniceSort,
                            items: UcioniceSort.values
                                .map(
                                  (sort) => DropdownMenuItem(
                                    value: sort,
                                    child: Text(
                                      ucioniceSort[sort],
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
                                ucioniceNotifier.setUcioniceSort(value);
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
                              'Dodaj novu učionicu',
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
        Consumer<UcioniceNotifier>(
          builder: (context, ucioniceNotifier, child) {
            if (ucioniceNotifier.getUcioniceLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (ucioniceNotifier.getUcioniceError) {
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
            if (ucioniceNotifier.ucionice.isEmpty &&
                !ucioniceNotifier.ucioniceFiltered) {
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
                          'Hmm izgleda da niste dodali učionicu',
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
            if (ucioniceNotifier.ucionice.isEmpty &&
                ucioniceNotifier.ucioniceFiltered) {
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
                  children: ucioniceNotifier.ucionice
                      .map((ucionica) => Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Text(
                                  ucionica.naslov,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    ucioniceNotifier
                                        .removeUcionica(ucionica.id!);
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
