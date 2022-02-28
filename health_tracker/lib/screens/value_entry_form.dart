import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:health_tracker/helpers/color_constants.dart';
import 'package:health_tracker/helpers/style_constants.dart';
import 'package:health_tracker/mock_data/mock_tracker_data.dart';
import 'package:health_tracker/models/tracker_detail_model.dart';
import 'package:intl/intl.dart';

class AddEditForm extends StatefulWidget {
  final MockTracker mockTracker;
  final TrackerDataModel? editModel;
  const AddEditForm(this.mockTracker, {Key? key, this.editModel})
      : super(key: key);

  @override
  _AddEditFormState createState() => _AddEditFormState();
}

class _AddEditFormState extends State<AddEditForm> {
  late TextEditingController _dateController;
  late DateTime _entryDate;
  late TextEditingController _valueController;
  bool _isEdit = false;
  TrackerDataModel? _trackerModel;

  @override
  void initState() {
    super.initState();
    if (widget.editModel != null) {
      _isEdit = true;
      _trackerModel = widget.editModel;
    } else {
      _trackerModel = TrackerDataModel();
    }

    _entryDate = _isEdit ? _trackerModel!.date : DateTime.now();
    _dateController = TextEditingController(
        text: DateFormat(' d MMM, ' 'yy')
            .format(_isEdit ? _trackerModel!.date : DateTime.now()));
    _valueController =
        TextEditingController(text: _isEdit ? _trackerModel!.value : '');
  }

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
        backgroundColor: ColorConstants.kAppBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(16, 30, 16, 0),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: ColorConstants.kTextPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "DATE",
                    style: kSubHeader,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextField(
                      style: kData,
                      controller: _dateController,
                      readOnly: _isEdit ? true : false,
                      onTap: () async {
                        if (_isEdit == false) {
                          DateTime today = DateTime.now();
                          FocusScope.of(context).unfocus();
                          await Future.delayed(
                              const Duration(milliseconds: 100));
                          var date = await showRoundedDatePicker(
                            height: 300,
                            context: context,
                            initialDate: _entryDate,
                            firstDate:
                                today.subtract(const Duration(days: 365 * 5)),
                            lastDate: today.add(const Duration(days: 365 * 3)),
                            borderRadius: 16,
                            styleDatePicker: MaterialRoundedDatePickerStyle(
                                paddingMonthHeader: const EdgeInsets.all(12),
                                textStyleMonthYearHeader: TextStyle(
                                    fontFamily: "Sen",
                                    fontSize: 15,
                                    color: ColorConstants.kTextPrimaryColor
                                        .withOpacity(0.8))),
                            theme: ThemeData(
                              primarySwatch: Colors.orange,
                              // ignore: deprecated_member_use
                              accentColor: ColorConstants.kActionButtonColor,
                            ),
                          );
                          if (date == null) {
                            return;
                          }

                          _entryDate = date;
                          var local = _entryDate.toLocal();

                          _dateController.text =
                              DateFormat(' d MMM, ' 'yy').format(local);

                          setState(() {});
                        } else {
                          null;
                        }
                      },
                      decoration: InputDecoration(
                          filled: _isEdit ? true : false,
                          fillColor: _isEdit
                              ? ColorConstants.kSecondaryTextColor
                                  .withOpacity(0.15)
                              : ColorConstants.kAppBackgroundColor,
                          suffixIcon: _isEdit
                              ? null
                              : const Icon(
                                  Icons.calendar_today_rounded,
                                  color: ColorConstants.kActionButtonColor,
                                  size: 24,
                                ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8))),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.mockTracker.displayName.toUpperCase() +
                        " (in " +
                        widget.mockTracker.unit +
                        ")",
                    style: kSubHeader,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextField(
                      style: kData,
                      controller: _valueController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8))),
                ],
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: TextButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ColorConstants.kActionButtonColor),
              fixedSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width * 0.95, 55)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 3),
            child: Text(
              _isEdit ? "SAVE" : "ADD",
              style: kSubHeader.copyWith(
                  color: ColorConstants.kAppBackgroundColor),
            ),
          ),
          onPressed: () async {
            var currentData = {
              "date": Timestamp.fromDate(_entryDate),
              "value": _valueController.text
            };

            _isEdit
                ? await FirebaseFirestore.instance
                    .collection(widget.mockTracker.id)
                    .doc(_trackerModel!.id)
                    .update(currentData)
                : await FirebaseFirestore.instance
                    .collection(widget.mockTracker.id)
                    .doc()
                    .set(currentData);
            Navigator.pop(context);
          },
        ),
      )),
    );
  }
}
