import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_tracker/models/tracker_detail_model.dart';

getTrackerDataStream(String id) {
  return FirebaseFirestore.instance
      .collection(id)
      .orderBy("date", descending: true)
      .snapshots()
      .map((snapshot) => TrackerDataListModel.fromSnapshotList(snapshot.docs));
}

getLatestTrackerDataEntry(String id) {
  return FirebaseFirestore.instance
      .collection(id)
      .orderBy("date", descending: true)
      .limit(1)
      .snapshots()
      .map((snapshot) => TrackerDataListModel.fromSnapshotList(snapshot.docs));
}
