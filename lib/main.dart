import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:payment_c7/my_observer.dart';
import 'package:payment_c7/screens/cash.dart';
import 'package:payment_c7/screens/payment_method.dart';
import 'package:payment_c7/screens/register/register.dart';
import 'package:payment_c7/screens/visa.dart';
import 'package:payment_c7/shared/network/remote/dio_helper.dart';

void main() {
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RegisterScreen.routeName,
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        CashScreen.routeName: (context) => CashScreen(),
        VisaScreen.routeName: (context) => VisaScreen(),
        PaymentMethod.routeName: (context) => PaymentMethod()
      },
    );
  }
}
