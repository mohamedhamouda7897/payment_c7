import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_c7/screens/payment_method.dart';
import 'package:payment_c7/screens/register/cubit/cubit.dart';
import 'package:payment_c7/screens/register/cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "RegisterScreen";

  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: BlocConsumer<PaymentCubit, PaymentStates>(
        listener: (context, state) {
          if (state is LoadingAuthTokenPaymentState) {
            print("Hiiii");
          }
          if (state is SuccessAuthTokenPaymentState) {
            print("Hiiii ahmed");
          }
          if (state is SuccessReferenceCodePaymentState) {
            Navigator.pushNamed(context, PaymentMethod.routeName);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Payment"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: fNameController,
                        decoration: InputDecoration(
                            hintText: "Fname",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue))),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        controller: lNameController,
                        decoration: InputDecoration(
                            hintText: "lName",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue))),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: "email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue))),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                            hintText: "phone",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue))),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        controller: amountController,
                        decoration: InputDecoration(
                            hintText: "amount",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue))),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            PaymentCubit.get(context).getAuthToken(
                                emailController.text,
                                phoneController.text,
                                fNameController.text,
                                lNameController.text,
                                amountController.text);
                          },
                          child: Text("Let's Go"))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
