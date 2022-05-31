import 'package:ehat/auth/firebase_auth_service.dart';
import 'package:ehat/providers/product_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String errMsg = '';
  late ProductProvider _productProvider;

  @override
  void didChangeDependencies(){
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            children: [
              const Center(child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Admin Login', style: TextStyle(fontSize: 30),),
              )),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
                //instead of controller:
                onSaved: (value) {
                  _email = value;
                },
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20,),
              Center(
                child: ElevatedButton(
                  child: Text('Login'),
                  onPressed: _loginAdmin,
                ),
              ),
              const SizedBox(height: 20,),
              Center(child: Text(errMsg, style: const TextStyle(fontSize: 16, color: Colors.red),))
            ],
          ),
        ),
      ),
    );
  }

  void _loginAdmin() async {

    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
          final user = await FirebaseAuthService.loginAdmin(_email!, _password!);
          if(user != null){
            final status = await _productProvider.checkAdmin(_email!);
            if(status){
              Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
            }else{
              await FirebaseAuthService.logoutAdmin();
              setState((){
                errMsg: "you are not an admin";
              });
            }
          }
      }on FirebaseAuthException catch (e) {
        setState(() {
          errMsg = e.message!;
        });
      }
    }
  }
}
