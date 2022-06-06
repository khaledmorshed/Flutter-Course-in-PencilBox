import 'package:ehat/auth/auth_service.dart';
import 'package:ehat/db/db_helper.dart';
import 'package:flutter/foundation.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> cartList = [];

  void addToCart(ProductModel productModel) {
    //jokhon add a press kora hobe tokhon productModel tai asbe.so datagulo
    //cartModel a assign kore diye productModel banate hobe
    final cartModel = CartModel(productId: productModel.id!,
        productName: productModel.name!, price: productModel.price!);
     DBHelper.addToCart(AuthService.currentUser!.uid, cartModel);
  }
  //get all cart items for every specific user
  void getAllCartItems() {
    DBHelper.fetchAllCartItemsForSpecificUser(AuthService.currentUser!.uid).listen((event) {
      cartList = List.generate(event.docs.length, (index) => CartModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }
  void removeFromCart(String id) {
    DBHelper.removeFromCart(AuthService.currentUser!.uid, id);
  }

  void increaseCartQunatity(CartModel cartModel) {
    cartModel.quantity += 1;
    DBHelper.updateCartQuantity(AuthService.currentUser!.uid, cartModel);
  }

  void decreaseCartQuantity(CartModel cartModel) {
    if(cartModel.quantity > 1){
      cartModel.quantity -= 1;
      DBHelper.updateCartQuantity(AuthService.currentUser!.uid, cartModel);
    }
  }

  void clearCart() {
    DBHelper.removeAllItemsFromCart(AuthService.currentUser!.uid, cartList);
  }

  bool isInCart(String id) {
    bool tag = false;
    //ekhane ak ak ta cart ak ak ta CartModel
    for(var cart in cartList){
      if(cart.productId == id){
        tag = true;
        break;
      }
    }
    return tag;
  }

  int get totalItemsInCart => cartList.length;

  num get cartItemsTotalPrice {
    num total = 0;
    // for(var cart in cartList){
    //   total += cart.quantity * cart.price;
    // }
    cartList.forEach((element) {
      total += element.quantity * element.price;
    });
    return total;
  }

  num grandTotal(int discount, int vat, int deliveryCharge) {
    var grandTotal = 0;

    return grandTotal;
  }

}