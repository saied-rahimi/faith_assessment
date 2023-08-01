import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For using jsonEncode and jsonDecode


void saveListToSharedPreferences(List<dynamic> dataList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonData = jsonEncode(dataList);
  await prefs.setString('dataList', jsonData);
}
