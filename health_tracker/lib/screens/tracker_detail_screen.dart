import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/helpers/color_constants.dart';
import 'package:health_tracker/helpers/style_constants.dart';
import 'package:health_tracker/mock_data/mock_tracker_data.dart';
import 'package:health_tracker/models/tracker_detail_model.dart';
import 'package:health_tracker/screens/value_entry_form.dart';
import 'package:intl/intl.dart';

class TrackerDetailScreen extends StatefulWidget {
  final MockTracker mockTracker;

  const TrackerDetailScreen(this.mockTracker, {Key? key}) : super(key: key);

  @override
  _TrackerDetailScreenState createState() => _TrackerDetailScreenState();
}

class _TrackerDetailScreenState extends State<TrackerDetailScreen> {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  String _prev = '';
  @override
  void initState() {
    super.initState();
    listenToData();
  }

  TrackerDataListModel _entries = TrackerDataListModel();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
            floatingActionButton: _getFAB(context),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            backgroundColor: ColorConstants.kAppBackgroundColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: ColorConstants.kTextPrimaryColor,
                      ),
                    ),
                  ),
                  Container(
                    height: 300,
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: _getChart(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [_createDataTable()],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _getFAB(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: FloatingActionButton(
        elevation: 0,
        onPressed: () async {
          await _analytics.logEvent(name: 'add_from_detail', parameters: {
            'add_form': widget.mockTracker.id,
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEditForm(widget.mockTracker)));
        },
        backgroundColor: ColorConstants.kActionButtonColor,
        child: const Icon(
          Icons.add_rounded,
          size: 40,
          color: ColorConstants.kAppBackgroundColor,
        ),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(
        columns: _createColumns(),
        rows: _createRows(_entries),
        showCheckboxColumn: false);
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
          label: Text(
        'Date',
        style: kSubHeader.copyWith(fontSize: 20),
      )),
      DataColumn(
          label: Expanded(
        child: Text(
          widget.mockTracker.displayName +
              "(" +
              // " (in " +
              widget.mockTracker.unit +
              ")",
          style: kSubHeader.copyWith(fontSize: 20),
        ),
      )),
    ];
  }

  List<DataRow> _createRows(TrackerDataListModel entries) {
    return entries.trackerDataList
        .map((entry) => DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context).colorScheme.primary.withOpacity(0.08);
              }
              return null;
            }),
            cells: [
              DataCell(Text(
                DateFormat("dd MMM, yyyy").format(entry.date),
                textAlign: TextAlign.center,
                style: kSubHeader.copyWith(fontWeight: FontWeight.w400),
              )),
              DataCell(
                  Text(
                    entry.value,
                    textAlign: TextAlign.center,
                    style: kSubHeader.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  showEditIcon: true),
            ],
            onSelectChanged: (bool? selected) {
              if (selected == null) {
                return;
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddEditForm(widget.mockTracker, editModel: entry)));
            }))
        .toList();
  }

  Future<void> listenToData() async {
    FirebaseFirestore.instance
        .collection(widget.mockTracker.id)
        .orderBy("date", descending: true)
        .snapshots()
        .listen((event) {
      _entries = TrackerDataListModel.fromSnapshotList(event.docs);
      if (mounted) {
        setState(() {}); //TODO: Provider
      }
    });
  }

  List<FlSpot> _getFlSpotList(TrackerDataListModel entries) {
    List<FlSpot> flSpotList = [];
    for (var element in entries.trackerDataList) {
      flSpotList.add(FlSpot(element.date.millisecondsSinceEpoch.toDouble(),
          double.parse(element.value)));
    }

    return flSpotList;
  }

  _getChart() {
    return LineChart(LineChartData(
        borderData: FlBorderData(show: false),
        gridData:
            FlGridData(drawHorizontalLine: false, drawVerticalLine: false),
        lineBarsData: [LineChartBarData(spots: _getFlSpotList(_entries))],
        titlesData: FlTitlesData(
            rightTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false),
            bottomTitles: SideTitles(
                showTitles: true,
                getTitles: (value) {
                  DateTime date =
                      DateTime.fromMillisecondsSinceEpoch(value.toInt());

                  var formattedDate = DateFormat('MMM').format(date);
                  if (_prev == formattedDate) return '';
                  _prev = formattedDate;
                  return formattedDate;
                }))));
  }
}
