import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app_timetable/providers/nastavni_plan_notifier.dart';
import 'package:web_app_timetable/providers/raspored_notifier.dart';
import 'package:web_app_timetable/shared/widgets/loader.dart';

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

class RasporedWidget extends StatelessWidget {
  const RasporedWidget({
    Key? key,
  }) : super(key: key);

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
      ],
    );
  }
}
