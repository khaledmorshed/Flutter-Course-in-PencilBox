
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehat/db/firestore_db_helper.dart';
import 'package:flutter/foundation.dart';

import '../models/product_model.dart';
import '../models/purchase_model.dart';

class ProductProvider extends ChangeNotifier {
  List<String> categoryList = [];
  List<ProductModel> productList = [];
  List<PurchaseModel>  purchaseList = [];

  void getAllProducts() {
      FirestoreDbHelper.getAllProducts().listen((snapshot) {
        //ekhane snapshot theke akta akta kore index dhore dhore map karon data return kore map er object
        //ei map er object ke ProductModel.fromMap() pathiye debo. snapshot theke joto gulo document
        //pabe prottekta document ke map a convert koere ak ta kore ProductModel abar convert kore
        //product list er moddhe rakhbe
          productList = List.generate(snapshot.docs.length, (index) => ProductModel.fromMap(snapshot.docs[index].data()));
          notifyListeners();
      });
  }

  //purchase list getting with specific id
  void getPurchaseByProductId(String id){
    FirestoreDbHelper.getPurchaseByProductId(id).listen((snapshot) {
      purchaseList = List.generate(snapshot.docs.length, (index)=> PurchaseModel.fromMap(snapshot.docs[index].data()));
    });
  }
  //a specific product query from firebase with id
  Stream<DocumentSnapshot<Map<String, dynamic>>> getProductByProductId(String id) => FirestoreDbHelper.getProductsByProductId(id);

  void getAllCategories() {
    //as it is stream so we use listen if it would be Future, we will use then
    FirestoreDbHelper.getCategories().listen((snapshot) {
      //snapshot.docs[index] == id of document.
      // snapshot.docs[index].data() = map of document
      //snapshot.docs[index].data()["name"] == get value with key
      categoryList = List.generate(snapshot.docs.length, (index) => snapshot.docs[index].data()["name"]);
      notifyListeners();
    });
  }

  Future<void> insertNewProduct(ProductModel productModel, PurchaseModel purchaseModel) {
    return FirestoreDbHelper.addNewProduct(productModel, purchaseModel);
  }


  Future<bool>checkAdmin(String email) {
    return FirestoreDbHelper.checkAdmin(email);
  }
}