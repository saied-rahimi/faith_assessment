import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For using jsonEncode and jsonDecode

class MyPref {
  void setMemberData(List<dynamic> dataList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(dataList);
    await prefs.setString('memberData', jsonData);
  }

  Future<List<dynamic>> getMemberData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString('memberData') ?? '[]';
    List<dynamic> dataList = jsonDecode(jsonData);
    return dataList;
  }

  void setManagerData(Map<String, dynamic> dataList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(dataList);
    await prefs.setString('managerData', jsonData);
  }

  Future<Map<String, dynamic>> getManagerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString('managerData') ?? '[]';
    Map<String, dynamic> dataList = jsonDecode(jsonData);
    return dataList;
  }
}
