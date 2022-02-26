import 'package:flutter/material.dart';
import 'package:health_tracker/helpers/color_constants.dart';
import 'package:health_tracker/helpers/style_constants.dart';

class TrackerDetailScreen extends StatefulWidget {
  const TrackerDetailScreen({Key? key}) : super(key: key);

  @override
  _TrackerDetailScreenState createState() => _TrackerDetailScreenState();
}

class _TrackerDetailScreenState extends State<TrackerDetailScreen> {
  final List<Map> _books = [
    {'date': '20/2', 'bp': '150/90'},
    {'date': "21/2", 'bp': '150/94'},
    {'date': "22/2", 'bp': '140/90'},
    {'date': "23/2", 'bp': '156/90'},
    {'date': "24/2", 'bp': '120/80'},
    {'date': "25/2", 'bp': '140/97'},
    {'date': "26/2", 'bp': '120/90'},
    {'date': "27/2", 'bp': '150/80'},
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return const [
      DataColumn(
          label: Text(
        'Date',
        style: kSubHeader,
      )),
      DataColumn(
          label: Expanded(
        child: Text(
          'Blood Pressure (in mm Hg)',
          style: kSubHeader,
        ),
      )),
    ]; //TODO: Sort function can be implemented here
  }

  List<DataRow> _createRows() {
    return _books
        .map((book) => DataRow(cells: [
              DataCell(Text(
                book['date'],
              )),
              DataCell(
                  Text(
                    book['bp'],
                  ),
                  showEditIcon: true),
            ]))
        .toList();
  }
}
