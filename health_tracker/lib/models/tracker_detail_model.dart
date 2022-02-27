import 'package:cloud_firestore/cloud_firestore.dart';

class TrackerDataModel {
  DateTime date = DateTime.now();
  String value = '';

  TrackerDataModel() {
    date = DateTime.now();
    value = '';
  }

  TrackerDataModel.fromDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    var json = snapshot.data() as Map<String, dynamic>;
    var timestamp = json['date'] as Timestamp;

    date = timestamp.toDate();
    value = json['value'];
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> data = {};

    data['date'] = Timestamp.fromDate(date);
    data['value'] = value;

    return data;
  }
}

class TrackerDataListModel {
  List<TrackerDataModel> trackerDataList = [];

  TrackerDataListModel() {
    trackerDataList = [];
  }

  TrackerDataListModel.fromSnapshotList(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> trackerList) {
    for (var trackerData in trackerList) {
      var trackerDataModel = TrackerDataModel.fromDocumentSnapshot(trackerData);
      trackerDataList.add(trackerDataModel);
    }
  }
}
