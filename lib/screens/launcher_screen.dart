import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import 'login_screen.dart';
import 'product_list_screen.dart';

class LauncherScreen extends StatefulWidget {
  static const String routeName = '/launcher';
  @override
  _LauncherScreenState createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if(AuthService.currentUser == null ) {
       // print("${AuthService.currentUser.toString()} + 1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ");
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }else {
        Navigator.pushReplacementNamed(context, ProductListScreen.routeName);
        //print("${AuthService.currentUser.toString()} + 2 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ");
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
