import 'package:flutter/material.dart';
import 'package:health_tracker/helpers/color_constants.dart';
import 'package:health_tracker/helpers/string_constants.dart';
import 'package:health_tracker/helpers/style_constants.dart';
import 'package:health_tracker/mock_data/mock_tracker_data.dart';
import 'package:health_tracker/reusable_widgets/health_tracker_card.dart';

class TrackerListingScreen extends StatefulWidget {
  const TrackerListingScreen({Key? key}) : super(key: key);

  @override
  _TrackerListingScreenState createState() => _TrackerListingScreenState();
}

class _TrackerListingScreenState extends State<TrackerListingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConstants.kAppBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 60),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kHello,
                    style: kHeader.copyWith(
                        fontWeight: FontWeight.w500, fontSize: 35),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(kName, style: kHeader.copyWith(fontSize: 50)),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                ColorConstants.kActionButtonColor)),
                        child: Text(
                          '+ Link new tracker',
                          style: kData.copyWith(
                              color: ColorConstants.kAppBackgroundColor,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          //To add a new tracker, implement
                        },
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: MockTrackerList.mockTrackers.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        child: HealthTrackerCard(
                          MockTrackerList.mockTrackers[index],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
