import 'dart:io';
import 'package:ehat/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../utils/constants.dart';

class ProductListScreen extends StatefulWidget {
  static const String routeName = '/products';

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductProvider _productProvider;

  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: _productProvider.productList.isEmpty ? Center(
        child: Text('No items found'),
      ) : ListView.builder(
        itemCount: _productProvider.productList.length,
        itemBuilder: (context, index) {
          final product = _productProvider.productList[index];
          return Card(
            elevation: 5,
            child: ListTile(
              onTap: (){
                Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: [product.productId, product.name]);
              },
              title: Text(product.name!),
              leading: fadedImageWidget(product.imageDownloadUrl!),
              trailing: Chip(
                label: Text('$takaSymbol${product.price}'),
              )
            ),
          );
        },
      ),
    );
  }

  Widget fadedImageWidget(String url) {
    return FadeInImage.assetNetwork(
        fadeInDuration: const Duration(seconds: 3),
        //animation
        fadeInCurve: Curves.bounceInOut,
        fit: BoxFit.cover,
        //showing default image until image not coming from network
        placeholder: 'assets/images/imageplaceholder.png',
        //network when comes
        image: url
    );
  }
}
