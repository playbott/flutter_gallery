import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:photo_gallery/environment.gen.dart';

Future<bool> hasInternetConnection() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult.first == ConnectivityResult.none) {
    return false;
  }
  try {
    final result = await InternetAddress.lookup(Env.lookupDomain);
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}
