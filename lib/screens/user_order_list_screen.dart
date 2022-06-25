
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';
import '../providers/order_provider.dart';
import '../utils/helper_functions.dart';
import 'order_details_screen.dart';

class UserOrderListScreen extends StatefulWidget {
  static const String routeName = '/user_orders';

  const UserOrderListScreen({Key? key}) : super(key: key);

  @override
  _UserOrderListScreenState createState() => _UserOrderListScreenState();
}

class _UserOrderListScreenState extends State<UserOrderListScreen> {
  late OrderProvider _orderProvider;

  @override
  void didChangeDependencies() {
    _orderProvider = Provider.of<OrderProvider>(context);
    _orderProvider.getUserOrders(AuthService.currentUser!.uid);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: _orderProvider.userOrderList.length,
        itemBuilder: (context, index) {
          final order = _orderProvider.userOrderList[index];
          return ListTile(
            onTap: () => Navigator.pushNamed(context, OrderDetailsScreen.routeName, arguments: order.orderId),
            title: Text(getFormattedDate(order.timestamp.millisecondsSinceEpoch, 'dd/MM/yyyy hh:mm a')),
            trailing: Text(order.orderStatus),
          );
        },
      ),
    );
  }
}
