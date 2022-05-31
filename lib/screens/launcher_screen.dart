
import 'package:ehat/auth/firebase_auth_service.dart';
import 'package:ehat/screens/dashboard_screen.dart';
import 'package:ehat/screens/login_screen.dart';
import 'package:flutter/material.dart';

class LauncherScreen extends StatefulWidget {
  static const String routeName = '/launcher';
  @override
  _LauncherScreenState createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {

  @override
  void initState() {
    //we know initState will call at fire.but we need to build this widget at first
    //so after build this widget then we will go to build another widget
    Future.delayed(Duration.zero, (){
      if(FirebaseAuthService.currentUser != null){
        Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
      }else{
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}
