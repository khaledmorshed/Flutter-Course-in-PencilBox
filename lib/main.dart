import 'package:ehat/providers/product_provider.dart';
import 'package:ehat/screens/launcher_screen.dart';
import 'package:ehat/screens/login_screen.dart';
import 'package:ehat/screens/new_product_screen.dart';
import 'package:ehat/screens/product_details_screen.dart';
import 'package:ehat/screens/product_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/dashboard_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  LauncherScreen(),
      routes: {
        NewProductScreen.routeName: (context) => NewProductScreen(),
        LoginScreen.routeName: (context)=> LoginScreen(),
        LauncherScreen.routeName: (context)=>LauncherScreen(),
        ProductListScreen.routeName: (context)=> ProductListScreen(),
        DashboardScreen.routeName: (context)=> DashboardScreen(),
        ProductDetailsScreen.routeName: (context)=> ProductDetailsScreen(),
      },
    );
  }
}