import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehat/providers/user_provider.dart';
import 'package:ehat/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';
import '../models/order_model.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';
import 'order_successful_screen.dart';

class CheckoutScreen extends StatefulWidget {
  static const String routeName = '/checkout';

  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late CartProvider _cartProvider;
  late OrderProvider _orderProvider;
  late UserProvider _userProvider;
  String radioGroupValue = Payment.cod;
  final _addressController = TextEditingController();
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if(_isInit){
      _cartProvider = Provider.of<CartProvider>(context);
      _orderProvider = Provider.of<OrderProvider>(context);
      _userProvider = Provider.of<UserProvider>(context);
      _orderProvider.getOrderConstants();
      _userProvider.getCurrentUserDetails(AuthService.currentUser!.uid).then((user){
        if(user != null){
          if(user.deliveryAddress != null){
            setState((){
              _addressController.text = user.deliveryAddress!;
            });
          }
        }
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                const Text('Your Items', style: TextStyle(fontSize: 20),),
                const Divider(height: 1, color: Colors.black,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _cartProvider.cartList.map((cartModel) => ListTile(
                    title: Text(cartModel.productName),
                    trailing: Text('${cartModel.quantity}x${cartModel.price}'),
                  )).toList(),
                ),
                const Text('Order Summery', style: TextStyle(fontSize: 20),),
                const Divider(height: 1, color: Colors.black,),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Cart Total'),
                        Text('$takaSymbol${_cartProvider.cartItemsTotalPrice}',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delivery Charge'),
                        Text('$takaSymbol${_orderProvider.orderConstantsModel.deliveryCharge}',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Discount(${_orderProvider.orderConstantsModel.discount}%)'),
                        Text('-$takaSymbol${_orderProvider.getDiscountAmount(_cartProvider.cartItemsTotalPrice)}',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('VAT(${_orderProvider.orderConstantsModel.vat}%)'),
                        Text('$takaSymbol${_orderProvider.getTotalVatAmount(_cartProvider.cartItemsTotalPrice)}',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)
                      ],
                    ),
                    const Divider(height: 1, color: Colors.black,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Grand Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        Text('$takaSymbol${_orderProvider.getGrandTotal(_cartProvider.cartItemsTotalPrice)}',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)
                      ],
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
                const Text('Set Delivery Address', style: TextStyle(fontSize: 20),),
                const Divider(height: 1, color: Colors.black,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                const Text('Select Payment Method', style: TextStyle(fontSize: 20),),
                const Divider(height: 1, color: Colors.black,),
                Row(
                  children: [
                    Radio<String>(
                      groupValue: radioGroupValue,
                      value: Payment.cod,
                      onChanged: (value) {
                        setState(() {
                          radioGroupValue = value!;
                        });
                      },
                    ),
                    Text(Payment.cod)
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      groupValue: radioGroupValue,
                      value: Payment.online,
                      onChanged: (value) {
                        setState(() {
                          radioGroupValue = value!;
                        });
                      },
                    ),
                    const Text(Payment.online)
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              child: const Text('PLACE ORDER'),
              onPressed: _saveOrder,
            ),
          )
        ],
      ),
    );
  }

  void _saveOrder() {
    if(_addressController.text.isEmpty) {
      showMsg(context, 'Please provide a delivery address');
      return;
    }
    _userProvider.updateUserAddress(AuthService.currentUser!.uid, _addressController.text);
    final orderModel = OrderModel(
      userId: AuthService.currentUser!.uid,
      timestamp: Timestamp.now(),
      orderStatus: OrderStatus.pending,
      paymentMethod: radioGroupValue,
      discount: int.parse('${_orderProvider.orderConstantsModel.discount}'),
      deliveryAddress: _addressController.text,
      vat: int.parse('${_orderProvider.orderConstantsModel.vat}'),
      deliveryCharge: int.parse('${_orderProvider.orderConstantsModel.deliveryCharge}'),
      grandTotal: _orderProvider.getGrandTotal(_cartProvider.cartItemsTotalPrice),
    );
    _orderProvider.addNewOrder(orderModel, _cartProvider.cartList).
    then((value){
      _cartProvider.clearCart();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> OrderSuccessfulScreen()), ModalRoute.withName(ProductListScreen.routeName));
    });
  }
}
