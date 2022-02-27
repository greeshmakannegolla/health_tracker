import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/helpers/color_constants.dart';
import 'package:health_tracker/helpers/style_constants.dart';
import 'package:health_tracker/models/tracker_detail_model.dart';
import 'package:health_tracker/screens/value_entry_form.dart';

class TrackerDetailScreen extends StatefulWidget {
  const TrackerDetailScreen({Key? key}) : super(key: key);

  @override
  _TrackerDetailScreenState createState() => _TrackerDetailScreenState();
}

class _TrackerDetailScreenState extends State<TrackerDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenToData();
  }

  TrackerDataListModel _entries = TrackerDataListModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: FloatingActionButton(
              elevation: 0,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddEditForm()));
              },
              backgroundColor: ColorConstants.kActionButtonColor,
              child: const Icon(
                Icons.add_rounded,
                size: 40,
                color: ColorConstants.kAppBackgroundColor,
              ),
            ),
          ),
          backgroundColor: ColorConstants.kAppBackgroundColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: ColorConstants.kTextPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 360, //TODO: Show graph
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
              )
            ],
          )),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows(_entries));
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
          'Blood Pressure \n(in mm Hg)', //TODO: Change from db, check UI issue
          style: kSubHeader.copyWith(fontSize: 20),
        ),
      )),
    ];
  }

  List<DataRow> _createRows(TrackerDataListModel entries) {
    return entries.trackerDataList
        .map((entry) => DataRow(cells: [
              DataCell(Text(
                entry.date.toString(), //TODO:Format
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
            ]))
        .toList();
  }

  Future<void> listenToData() async {
    FirebaseFirestore.instance
        .collection('bp_data') //TODO: Need to change collection name acc.
        .snapshots()
        .listen((event) {
      _entries = TrackerDataListModel.fromSnapshotList(event.docs);
      if (mounted) {
        setState(() {});
      }
    });
  }
}
