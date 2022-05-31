import 'package:ehat/auth/firebase_auth_service.dart';
import 'package:ehat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../widgets/dashboard_button.dart';
import 'new_product_screen.dart';
import 'product_list_screen.dart';


class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ProductProvider _productProvider;
  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _productProvider.getAllProducts();
    _productProvider.getAllCategories();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
                FirebaseAuthService.logoutAdmin().then((value){
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                });
            },
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        children: [
          DashboardButton(
            label: 'Add Product',
            onPressed: () => Navigator.pushNamed(context, NewProductScreen.routeName),
          ),
          DashboardButton(
            label: 'View Product',
            onPressed: () => Navigator.pushNamed(context, ProductListScreen.routeName),
          ),
        DashboardButton(
          label: 'View Product',
          onPressed: () => Navigator.pushNamed(context, ProductListScreen.routeName),
        ),
          DashboardButton(
            label: 'View Product',
            onPressed: () => Navigator.pushNamed(context, ProductListScreen.routeName),
          ),
          DashboardButton(
            label: 'View Product',
            onPressed: () => Navigator.pushNamed(context, ProductListScreen.routeName),
          ),
          DashboardButton(
            label: 'View Product',
            onPressed: () => Navigator.pushNamed(context, ProductListScreen.routeName),
          ),
          DashboardButton(
            label: 'View Product',
            onPressed: () => Navigator.pushNamed(context, ProductListScreen.routeName),
          ),
        ],
      ),
    );
  }
}
