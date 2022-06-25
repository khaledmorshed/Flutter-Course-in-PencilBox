import 'package:ehat/providers/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'providers/user_provider.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/launcher_screen.dart';
import 'screens/login_screen.dart';
import 'screens/order_details_screen.dart';
import 'screens/order_successful_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/product_list_screen.dart';
import 'screens/user_order_list_screen.dart';
import 'screens/user_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LauncherScreen(),
      routes: {
        LauncherScreen.routeName : (context) => LauncherScreen(),
        LoginScreen.routeName : (context) => LoginScreen(),
        ProductListScreen.routeName : (context) => ProductListScreen(),
        ProductDetailsScreen.routeName : (context) => ProductDetailsScreen(),
        UserProfileScreen.routeName : (context) => UserProfileScreen(),
        CartScreen.routeName : (context) => CartScreen(),
        CheckoutScreen.routeName : (context) => CheckoutScreen(),
        OrderSuccessfulScreen.routeName : (context) => OrderSuccessfulScreen(),
        UserOrderListScreen.routeName : (context) => UserOrderListScreen(),
        OrderDetailsScreen.routeName : (context) => OrderDetailsScreen(),
      },
    );
  }
}

