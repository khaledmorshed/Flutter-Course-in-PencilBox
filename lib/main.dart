import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitual_visiting_card/screens/contact_details_screen.dart';
import 'package:vitual_visiting_card/screens/contact_list_screen.dart';
import 'package:vitual_visiting_card/screens/new_contact_screen.dart';
import 'package:vitual_visiting_card/screens/scan_screen.dart';

import 'providers/contact_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ContactProvider()/*..getAllContactsInProvider()*/,
      child: MyApp()));
}
//fdfdfdfd
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'virtual visiting card',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: ContactListScreen.path,
      routes: {
        ContactListScreen.path: (context) => ContactListScreen(),
        NewContactScreen.path: (context) => NewContactScreen(),
        ContactDetailsScreen.path: (context) => ContactDetailsScreen(),
        ScanScreen.path: (context) => ScanScreen(),
      },
    );
  }
}
