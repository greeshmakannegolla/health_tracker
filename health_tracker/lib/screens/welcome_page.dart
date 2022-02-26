import 'package:flutter/material.dart';
import 'package:health_tracker/helpers/color_constants.dart';
import 'package:health_tracker/helpers/string_constants.dart';
import 'package:health_tracker/helpers/style_constants.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.kAppBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 10, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(kWelcome),
              const SizedBox(
                height: 100,
              ),
              const Text(
                kWelcomeMessage,
                style: kHeader,
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: FloatingActionButton(
            elevation: 0,
            onPressed: () async {
              // await Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => AddIncome(
              //             this.widget.property,
              //             this.widget.propertyUnit,
              //             this._refreshIncomeList,
              //             propertyDetail: _propertyDetail)));
            },
            backgroundColor: ColorConstants.kTextPrimaryColor,
            child: const Icon(
              Icons.chevron_right_rounded,
              size: 40,
              color: ColorConstants.kAppBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
