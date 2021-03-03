import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';
import '../providers/OrdersProvider.dart' show OrdersProvider;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

/**
 * When will use provider then whole widget will rebuild but using consumer only specifically allowed widget will rebuild
 */
  @override
  Widget build(BuildContext context) {
    print('buinding order');
    // final orderData = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrdersProvider>(context, listen: false)
            .fetchAndSetOrders(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          //  else {
          // if (dataSnapshot.error != null) {
          //   return Center(
          //     child: Text('An error occured'),
          //   );
          // }
          else {
            return Consumer<OrdersProvider>(
              builder: (context, orderData, child) => ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (context, i) => OrderItem(orderData.orders[i]),
              ),
            );
          }
        },
      ),
    );
  }
}
