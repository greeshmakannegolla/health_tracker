import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:health_tracker/helpers/color_constants.dart';
import 'package:health_tracker/helpers/style_constants.dart';
import 'package:intl/intl.dart';

class AddEditForm extends StatefulWidget {
  const AddEditForm({Key? key}) : super(key: key);

  @override
  _AddEditFormState createState() => _AddEditFormState();
}

class _AddEditFormState extends State<AddEditForm> {
  late TextEditingController _dateController;
  late DateTime _entryDate;
  late TextEditingController _valueController;

  @override
  void initState() {
    super.initState();
    _entryDate = DateTime.now();
    _dateController = TextEditingController(
        text: DateFormat(' d MMM, ' 'yy')
            .format(DateTime.now())); //TODO: Needs to change for edit
    _valueController = TextEditingController();
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
                      onTap: () async {
                        DateTime today = DateTime.now();
                        FocusScope.of(context).unfocus();
                        await Future.delayed(const Duration(milliseconds: 100));
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
                      },
                      decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.calendar_today_outlined,
                            color: ColorConstants.kActionButtonColor,
                            size: 18,
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
                  const Text(
                    "BLOOD PRESSURE", //TODO: Populate acc. to data
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
              "ADD",
              style: kSubHeader.copyWith(
                  color: ColorConstants.kAppBackgroundColor),
            ),
          ),
          onPressed: () async {
            var currentData = {
              "date": Timestamp.fromDate(_entryDate),
              "value": _valueController.text
            };

            await FirebaseFirestore.instance
                .collection('bp_data')
                .doc()
                .set(currentData);
            Navigator.pop(context);
          },
        ),
      )),
    );
  }
}
