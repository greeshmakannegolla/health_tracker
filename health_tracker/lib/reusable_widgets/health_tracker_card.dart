import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/helpers/style_constants.dart';
import 'package:health_tracker/mock_data/mock_tracker_data.dart';
import 'package:health_tracker/models/tracker_detail_model.dart';
import 'package:health_tracker/screens/tracker_detail_screen.dart';
import 'package:health_tracker/screens/value_entry_form.dart';
import 'package:provider/provider.dart';

import '../helpers/db_helper.dart';

class HealthTrackerCard extends StatefulWidget {
  final MockTracker mockTracker;
  const HealthTrackerCard(this.mockTracker, {Key? key}) : super(key: key);

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
          'view_card': widget.mockTracker.id,
        });
        _goToDetails(context);
      },
      child: Card(
        color: widget.mockTracker.color.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          widget.mockTracker.iconPath,
                          color: widget.mockTracker.color,
                          height: 25,
                          width: 25,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.mockTracker.displayName,
                          style: kSubText.copyWith(
                            color: widget.mockTracker.color,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(_getLatestValue() + ' ' + widget.mockTracker.unit,
                        style: kSubText.copyWith(
                            color: widget.mockTracker.color, fontSize: 35))
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () async {
                    await _analytics
                        .logEvent(name: 'add_data_from_home', parameters: {
                      'add_data': widget.mockTracker.id,
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddEditForm(widget.mockTracker)));
                  },
                  child: Icon(
                    Icons.add_circle_rounded,
                    size: 50,
                    color: widget.mockTracker.color,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _goToDetails(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StreamProvider<TrackerDataListModel>.value(
          initialData: TrackerDataListModel(),
          value: getTrackerDataStream(widget.mockTracker.id),
          child: TrackerDetailScreen(widget.mockTracker));
    }));
  }

  String _getLatestValue() {
    var entries = context.watch<TrackerDataListModel>();
    if (entries.trackerDataList.isNotEmpty) {
      return entries.trackerDataList[0].value;
    }
    return '...';
  }
}
