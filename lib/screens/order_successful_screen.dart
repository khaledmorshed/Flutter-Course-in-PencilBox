import 'package:flutter/material.dart';

class OrderSuccessfulScreen extends StatefulWidget {
  static const String routeName = '/successful';

  const OrderSuccessfulScreen({Key? key}) : super(key: key);

  @override
  _OrderSuccessfulScreenState createState() => _OrderSuccessfulScreenState();
}

class _OrderSuccessfulScreenState extends State<OrderSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Successful'),),
      body: Center(
        child: Column(
          children: [
            Text('Your order has been placed'),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text('Go back to Home'))
          ],
        ),
      ),
    );
  }
}
