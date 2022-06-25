import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productList = [];
  List<String> categoryList = [];
  List<String> testList = [];

  Future<void> getAllProducts()async {
    DBHelper.fetchAllProducts().listen((event) {
      print("1 + {event.docs[0]} + TTTTAAAAAAAAAAAAAAAAAAAAAa");
      productList = List.generate(event.docs.length, (index) => ProductModel.fromMap(event.docs[index].data()));
      print("2 + ${event.docs[0].data().length} + TTTTAAAAAAAAAAAAAAAAAAAAAa");
      notifyListeners();
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProductByProductId(String productId) {
    return DBHelper.fetchProductByProductId(productId);
  }

  void getAllCategories() {
    DBHelper.fetchAllCategories().listen((event) {
      categoryList = List.generate(event.docs.length, (index) => event.docs[index].data()['name']);
      notifyListeners();
    });
  }

}