import 'dart:io';

const String apiUrl =
    "https://yusuf-shopping-api-default-rtdb.europe-west1.firebasedatabase.app";

const String getAllItems = "/items.json";

Future<bool> checkInternetConnection() async {
  final result = await InternetAddress.lookup('www.google.com');
  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    return true;
  }
  return false;
}
