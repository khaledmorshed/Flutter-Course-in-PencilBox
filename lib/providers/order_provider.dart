
import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';
import '../models/cart_model.dart';
import '../models/order_constants_model.dart';
import '../models/order_model.dart';

class OrderProvider with ChangeNotifier {
  //orderConstantsModel eita list hobe na jehetu aktai model ase firebase a
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();
  List<OrderModel> userOrderList = [];
  List<CartModel> orderDetailsList = [];

  void getOrderConstants() async {
    DBHelper.fetchOrderConstants().listen((snapshot) {
      if(snapshot.exists){
        orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
      }
    });
  }

  void getOrderDetails(String orderId) async {

  }

  void getUserOrders(String userId) async {

  }

  num getDiscountAmount(num total) {
    return ((total * orderConstantsModel.discount)/100);
  }

  num getTotalVatAmount(num total) {
    final totalAfterDiscount = total - getDiscountAmount(total);
    return ((totalAfterDiscount * orderConstantsModel.vat)/100);
  }

  num getGrandTotal(num total) {
    return total - getDiscountAmount(total) + getTotalVatAmount(total) + orderConstantsModel.deliveryCharge;
  }

  Future<void> addNewOrder(OrderModel orderModel, List<CartModel> cartModels) {
    return DBHelper.addNewOrder(orderModel, cartModels);
  }
}