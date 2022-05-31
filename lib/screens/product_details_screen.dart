import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehat/models/product_model.dart';
import 'package:ehat/providers/product_provider.dart';
import 'package:ehat/utils/constants.dart';
import 'package:ehat/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product_details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String proudctName = "";
  String? productId;
  late ProductProvider _productProvider;
  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    productId = argList[0];
    proudctName  = argList[1];
    _productProvider.getPurchaseByProductId(productId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(proudctName),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) => StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: provider.getProductByProductId(productId!),
            builder: (context, snapshot){
              if(snapshot.hasData){
                final product = ProductModel.fromMap(snapshot.data!.data()!);
                return ListView(
                  children: [
                    FadeInImage.assetNetwork(
                        fadeInDuration: const Duration(seconds: 3),
                        //animation
                        fadeInCurve: Curves.bounceInOut,
                        fit: BoxFit.cover,
                        //showing default image until image not coming from network
                        placeholder: 'assets/images/imageplaceholder.png',
                        //network when comes
                        image: product.imageDownloadUrl!,
                      width: double.infinity,
                      height: 250,
                    ),
                    ListTile(
                      title: Text(product.name!),
                      subtitle: Text(product.category!),
                    ),
                    ListTile(
                      title: Text("Sale price: ${product.price}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Description", style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    ListTile(
                      title: Text("${product.description}"),
                    ),
                    ListTile(
                      title: Text("Purchase history"),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: provider.purchaseList.map((purchase){
                          return ListTile(
                            title: Text(getFormattedDate(purchase.purchaseDate.toDate(), "MMM dd, yyyy")),
                            trailing: Text("$takaSymbol${purchase.purchasePrice}"),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              }
              if(snapshot.hasError){
                return Text("Fail to load data");
              }
              return CircularProgressIndicator();
            }
        ),
      ),
    );
  }
}
