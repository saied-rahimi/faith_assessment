import 'package:faith_assessment/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("fa", "IR")],
      locale: const Locale("fa", "IR"),
      title: 'محاسب',
      theme: ThemeData(
        fontFamily: 'iransans',
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List defaultAssess = [
    {'title': 'جماعت', 'type': 'متن'},
    {'title': 'تلاوت', 'type': 'متن'},
    {'title': 'اذکار', 'type': 'متن'},
    {'title': 'مطالعه', 'type': 'متن'},
  ];
  getData()async{
    var data = await MyPref().getAssessData();
    if(data.isEmpty){
      MyPref().setAssessData(defaultAssess);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return const MyNavigationBar();
  }
}
