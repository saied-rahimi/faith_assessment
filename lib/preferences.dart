import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For using jsonEncode and jsonDecode

class MyPref {
  void setMemberData(Map<String, dynamic> dataMap) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(dataMap);
    await prefs.setString('memberData', jsonData);
  }

  Future<Map<String, dynamic>> getMemberData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString('memberData') ?? '{}';
    Map<String, dynamic> dataMap = jsonDecode(jsonData);
    return dataMap;
  }

  void setUserAssessment(Map<String, dynamic> dataMap) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(dataMap);
    await prefs.setString('assessmentData', jsonData);
  }

  Future<Map<String, dynamic>> getUserAssessment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString('assessmentData') ?? '{}';
    Map<String, dynamic> dataMap = jsonDecode(jsonData);
    return dataMap;
  }

  void setAssessData(List<dynamic> dataList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(dataList);
    await prefs.setString('assessData', jsonData);
  }

  Future<List<dynamic>> getAssessData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString('assessData') ?? '[]';
    List<dynamic> dataList = jsonDecode(jsonData);
    return dataList;
  }

  void setManagerData(Map<String, dynamic> dataMap) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(dataMap);
    await prefs.setString('managerData', jsonData);
  }

  Future<Map<String, dynamic>> getManagerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString('managerData') ?? '{}';
    Map<String, dynamic> dataMap = jsonDecode(jsonData);
    return dataMap;
  }
}
