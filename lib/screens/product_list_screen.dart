import 'package:ehat/providers/cart_provider.dart';
import 'package:ehat/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/main_drawer.dart';
import 'cart_screen.dart';

class ProductListScreen extends StatefulWidget {
  static const String routeName = '/product_list';

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductProvider _productProvider;
  late CartProvider _cartProvider;
  bool _init = true;

  @override
  void didChangeDependencies(){
    if(_init){
      _productProvider =  Provider.of<ProductProvider>(context);
      _cartProvider =  Provider.of<CartProvider>(context);
      _productProvider.getAllProducts().then((value){
        _cartProvider.getAllCartItems();
        setState((){
          _init = false;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, CartScreen.routeName),
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.68,
        children: _productProvider.productList.map((e) => ProductItem(e)).toList(),
      ),
    );
  }
}
