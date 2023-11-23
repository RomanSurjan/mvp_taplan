import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvp_taplan/blocs/paymennt_bloc/payment_event.dart';
import 'package:mvp_taplan/blocs/paymennt_bloc/payment_state.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  static const String terminalKey = '1693297519489DEMO';
  static const String password = 'x19bdcqv23rvs8v7';

  PaymentBloc() : super(PaymentState()) {
    on<InitPaymentEvent>(_onInit);
  }

  _onInit(InitPaymentEvent event, Emitter<PaymentState> emitter) async {
    final amount = event.amount * 100;
    final orderId = await getPaymentId(event.presentId, amount, event.postcardSign);
    final token = getToken(amount, password, orderId, terminalKey);

    final map = {
      "TerminalKey": terminalKey,
      "Amount": amount,
      "OrderId": orderId,
      "Token": "$token",
    };

    final response = await Dio().post(
      'https://securepay.tinkoff.ru/v2/Init',
      data: map,
    );

    if (response.data['PaymentURL'] != null) {
      final Uri url = Uri.parse(response.data['PaymentURL']);
      if (!await launchUrl(url, webOnlyWindowName: '_self')) {
        throw Exception('Could not launch $url');
      }
    }
  }

  Future<String> getPaymentId(int presentId, int amount, String? postcardSign) async {
    final response = await Dio().post(
      'https://qviz.fun/api/v1/create/order/',
      data: {
        'present': presentId,
        'amount': amount,
        'postcard_sign': postcardSign,
      },
      options: Options(
        headers: {
          'Authorization': 'Token 69f8e37d2d234198b8d45b0d1f7073386c026173',
        },
      ),
    );



    return response.data['id'];
  }

  Digest getToken(int amount, String password, String paymentId, String terminalKey) {
    return sha256.convert(utf8.encode('$amount$password$paymentId$terminalKey'));
  }
}
