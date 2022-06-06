import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cart_model.dart';
import '../models/order_model.dart';
import '../models/user_model.dart';

class DBHelper {
  static const _collectionProduct = 'Products';
  static const _collectionCategory = 'Categories';
  static const _collectionUser = 'Users';
  static const _collectionCart = 'Cart';
  static const _collectionOrder = 'Orders';
  static const _collectionOrderDetails = 'OrderDetails';
  static const _collectionOrderUtils = 'OrderUtils';
  static const _documentConstants = 'Constants';

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

//adding new user
  static Future<void> addNewUser(UserModel userModel) async{
    return _db.collection(_collectionUser).doc(userModel.userId).set(userModel.toMap());
  }
  //fetch user details
  //here get() will fetch data just one time so Data Type will be Future
  static Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserDetails(String userId) =>
      _db.collection(_collectionUser).doc(userId).get();

  //update delivey address
  static Future<void> updateDeliveryAddress(String userId, String newAddress) async{
    // final snapshot = await fetchUserDetails(userId);
    // final userDetails = UserModel.fromMap(snapshot.data()!);
    // //if delivery address stays before , then we will not update user information
    // if(userDetails.deliveryAddress != null){
    //   return;
    // }
    //first time setting address when deliveryAddress is null
    return _db.collection(_collectionUser).doc(userId).update({'deliveryAddress': newAddress});
  }

  //adding product into cart in firebase
  static Future<void> addToCart(String userId, CartModel cartModel) {
      return _db.collection(_collectionUser).doc(userId).collection(_collectionCart)
          .doc(cartModel.productId).set(cartModel.toMap());
  }

  //updating cart's qunatity
  static Future<void> updateCartQuantity(String userId, CartModel cartModel) {
    return _db.collection(_collectionUser).doc(userId).collection(_collectionCart)
        .doc(cartModel.productId).update({"quantity": cartModel.quantity});
  }

  //remove from cart using remove button
  static Future<void> removeFromCart(String userId, String productId) {
    return _db.collection(_collectionUser).doc(userId).collection(_collectionCart)
        .doc(productId).delete();
  }

  //clear cart
  static Future<void> removeAllItemsFromCart(String userId, List<CartModel> cartList) {
    //first we need all document id of cart collection then we will delete
    final wb = _db.batch();
    for(var cart in cartList){
      final cartDoc = _db.collection(_collectionUser).doc(userId).collection(_collectionCart).
                      doc(cart.productId);
      //all product id wll assign into wb.delete collection then we will commit
      wb.delete(cartDoc);
    }
    return wb.commit();
  }

  static addNewOrder(OrderModel orderModel, List<CartModel> cartList) {
    final wb = _db.batch();
    //creating a new doc for batch operation
    final orderDoc = _db.collection(_collectionOrder).doc();
    orderModel.orderId = orderDoc.id;
    wb.set(orderDoc, orderModel.toMap());
    //here _collectionOrderDetails
    for(var cart in cartList){
      final doc = orderDoc.collection(_collectionOrderDetails).doc(cart.productId);
      wb.set(doc, cart.toMap());
    }
    return wb.commit();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllOrdersByUser(String userId) =>
      _db.collection(_collectionOrder).where('user_id', isEqualTo: userId).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllOrderDetails(String orderId) =>
      _db.collection(_collectionOrder).doc(orderId).collection(_collectionOrderDetails).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllCategories() =>
      _db.collection(_collectionCategory).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllProducts() =>
      _db.collection(_collectionProduct).where("isAvailable", isEqualTo: true).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> fetchProductByProductId(String productId) =>
      _db.collection(_collectionProduct).doc(productId).snapshots();

  //jehetu akta document er upor snapshot(_documentConstants) dicci tai QuerySnapshot
  // na hoye DocumentSnapshot hobe
  static Stream<DocumentSnapshot<Map<String, dynamic>>> fetchOrderConstants() =>
      _db.collection(_collectionOrderUtils).doc(_documentConstants).snapshots();

  //getting all cart item
  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllCartItemsForSpecificUser(String userId){
    return _db.collection(_collectionUser).doc(userId).collection(_collectionCart)
        .snapshots();
  }

}