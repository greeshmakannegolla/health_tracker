import 'package:flutter/material.dart';
import 'package:health_tracker/helpers/color_constants.dart';
import 'package:health_tracker/helpers/string_constants.dart';
import 'package:health_tracker/helpers/style_constants.dart';
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
                    height: 20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: 1, //TODO: Change later
                    itemBuilder: (BuildContext ctx, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        child: InkWell(
                            onTap: () {
                              //Navigation to the selected health tracker
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           RestaurantDetailScreen(
                              //               _filteredRestaurantList[index])),
                              // );
                            },
                            child: const HealthTrackerCard(
                                // _filteredRestaurantList[index],
                                // key: UniqueKey(), //TODO: Send correct data
                                )),
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
