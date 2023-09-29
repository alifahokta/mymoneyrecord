import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mymoneyrecord/dbhelper/userProvider.dart';
import 'package:mymoneyrecord/route/route.dart';
import 'package:mymoneyrecord/pages/loginPage.dart';
import 'package:mymoneyrecord/pages/homePage.dart';
import 'package:mymoneyrecord/pages/pemasukanPage.dart';
import 'package:mymoneyrecord/pages/pengeluaranPage.dart';
import 'package:mymoneyrecord/pages/detailCashFlowPage.dart';
import 'package:mymoneyrecord/pages/pengaturanPage.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

final routes = {
  routeLogin: (BuildContext context) => loginPage(),
  routeHome: (BuildContext context) => homePage(),
  routePemasukan: (BuildContext context) => pemasukanPage(),
  routePengeluaran: (BuildContext context) => pengeluaranPage(),
  routeDetailCashFlow: (BuildContext context) => const detailCashFlowPage(),
  routePengaturan: (BuildContext context) => pengaturanPage(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Money Record",
      theme: ThemeData(primaryColor: Colors.blue),
      routes: routes,
    );
  }
}