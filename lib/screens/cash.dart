import 'package:flutter/material.dart';
import 'package:payment_c7/shared/compentens/constants.dart';

class CashScreen extends StatelessWidget {
  static const String routeName = "cash";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Text("Go TO SuperMarket and pay with ref code $REF_CODE")),
    );
  }
}
