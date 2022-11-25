import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  debugPrint = (String? message, {int? wrapWidth}) {
    if (!kReleaseMode) {
      log(message.toString());
    }
  };

  WidgetsFlutterBinding.ensureInitialized();

}