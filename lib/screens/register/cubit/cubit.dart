import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_c7/screens/register/cubit/states.dart';
import 'package:payment_c7/shared/network/remote/dio_helper.dart';

import '../../../shared/compentens/constants.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(InitPaymentState());

  static PaymentCubit get(context) => BlocProvider.of(context);

  void getAuthToken(
      String email, String phone, String fName, String lName, String amount) {
    emit(LoadingAuthTokenPaymentState());
    DioHelper.postData(endPoint: "auth/tokens", data: {"api_key": API_KEY})
        .then((value) {
      AUTH_TOKEN = value.data["token"];
      print("Route token > $AUTH_TOKEN");
      getOrderID(email, phone, fName, lName, amount);
      emit(SuccessAuthTokenPaymentState());
    }).catchError((error) {
      emit(ErrorAuthTokenPaymentState());
    });
  }

  void getOrderID(
      String email, String phone, String fName, String lName, String amount) {
    emit(LoadingOrderIdPaymentState());
    DioHelper.postData(endPoint: "ecommerce/orders", data: {
      "auth_token": AUTH_TOKEN,
      "delivery_needed": "false",
      "amount_cents": amount,
      "currency": "EGP",
      "items": []
    }).then((value) {
      ORDER_ID = value.data["id"].toString();
      getRequestTokenCard(email, phone, fName, lName, amount);
      getRequestTokenKiosk(email, phone, fName, lName, amount);

      emit(SuccessOrderIdPaymentState());
    }).catchError((error) {
      print(error);
      emit(ErrorOrderIdPaymentState());
    });
  }

  void getRequestTokenCard(
      String email, String phone, String fName, String lName, String amount) {
    emit(LoadingRequestTokenCardPaymentState());
    DioHelper.postData(endPoint: "acceptance/payment_keys", data: {
      "auth_token": AUTH_TOKEN,
      "amount_cents": amount,
      "expiration": 3600,
      "order_id": ORDER_ID,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": fName,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "EG",
        "last_name": lName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": INTERGRATIONCARDID
    }).then((value) {
      REQUEST_TOKEN_CARD = value.data["token"];
      emit(SuccessRequestTokenCardPaymentState());
    }).catchError((error) {
      emit(ErrorRequestTokenCardPaymentState());
    });
  }

  void getRequestTokenKiosk(
      String email, String phone, String fName, String lName, String amount) {
    emit(LoadingRequestTokenKioskPaymentState());
    DioHelper.postData(endPoint: "acceptance/payment_keys", data: {
      "auth_token": AUTH_TOKEN,
      "amount_cents": amount,
      "expiration": 3600,
      "order_id": ORDER_ID,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": fName,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "EG",
        "last_name": lName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": INTERGRATIONKIOSKID
    }).then((value) {
      REQUEST_TOKEN_KIOSK = value.data["token"];
      getRefCode();
      emit(SuccessRequestTokenKioskPaymentState());
    }).catchError((error) {
      emit(ErrorRequestTokenKioskPaymentState());
    });
  }

  void getRefCode() {
    emit(LoadingReferenceCodePaymentState());
    DioHelper.postData(endPoint: "acceptance/payments/pay", data: {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token": REQUEST_TOKEN_KIOSK
    }).then((value) {
      REF_CODE = value.data["id"].toString();
      print(AUTH_TOKEN);
      print(ORDER_ID);
      print(REQUEST_TOKEN_CARD);
      print(REQUEST_TOKEN_KIOSK);
      print(REF_CODE);
      emit(SuccessReferenceCodePaymentState());
    }).catchError((error) {
      emit(ErrorReferenceCodePaymentState());
    });
  }
}
