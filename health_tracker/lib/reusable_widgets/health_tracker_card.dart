import 'package:flutter/material.dart';
import 'package:health_tracker/helpers/color_constants.dart';
import 'package:health_tracker/helpers/style_constants.dart';
import 'package:health_tracker/screens/tracker_detail_screen.dart';
import 'package:health_tracker/screens/value_entry_form.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class HealthTrackerCard extends StatefulWidget {
  const HealthTrackerCard({Key? key}) : super(key: key);

  @override
  _HealthTrackerCardState createState() => _HealthTrackerCardState();
}

class _HealthTrackerCardState extends State<HealthTrackerCard> {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await _analytics.logEvent(name: 'tracker_detail', parameters: {
          'view_card': 1, //TODO: Send selected card index
        });
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TrackerDetailScreen()));
      },
      child: Card(
        color: ColorConstants.kBloodPressureColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite_border_rounded,
                        color: ColorConstants.kBloodPressureColor,
                      ),
                      //TODO:Get icon, color from prev screen
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Blood Pressure",
                        style: kSubText.copyWith(
                          color: ColorConstants.kBloodPressureColor,
                        ),
                      ) //TODO:Get from prev screen
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("120/80", //TODO: Get latest entry
                      style: kSubText.copyWith(
                          color: ColorConstants.kBloodPressureColor,
                          fontSize: 40))
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddEditForm()));
                },
                child: const Icon(
                  Icons.add_circle_rounded,
                  size: 50,
                  color: ColorConstants
                      .kBloodPressureColor, //TODO:Get from prev screen
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
