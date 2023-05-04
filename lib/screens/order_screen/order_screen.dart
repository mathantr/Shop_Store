import 'package:flutter/material.dart';
import 'package:shop_store/colors/colors.dart';
import 'package:shop_store/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:shop_store/models/order_models/order_models.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Orders',
          style: header.copyWith(
              color: black,
              fontSize: 22,
              letterSpacing: 2,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: FutureBuilder(
          future: FirebaseFirestoreHelper.instance.getUserOrder(),
          builder: (context, snapshot) {
            ///order Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.isEmpty || snapshot.data == null) {
              return Center(
                child: Text('No order Found'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                OrderModel orderModel = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: ExpansionTile(
                    backgroundColor: liteyellow,
                    collapsedBackgroundColor: liteyellow,
                    title: Text(
                      orderModel.payment,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Product Name  : ',
                                  style: header.copyWith(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    letterSpacing: 2,
                                  ),
                                ),
                                Text(orderModel.products[0].name.toUpperCase()),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Qty  : ',
                                  style: header.copyWith(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    letterSpacing: 2,
                                  ),
                                ),
                                Text(orderModel.products[0].qty.toString()),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Status  : ',
                                  style: header.copyWith(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    letterSpacing: 2,
                                  ),
                                ),
                                Text(
                                  orderModel.status.toUpperCase(),
                                  style: TextStyle(
                                      color: orderModel.status == 'pending'
                                          ? Colors.red
                                          : Colors.green,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Price',
                                  style: header.copyWith(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2,
                                  ),
                                ),
                                Text(
                                  ': \$${orderModel.totalPrice.toString()}',
                                  style: header.copyWith(
                                      color: black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                Image.network(
                                  orderModel.products[0].image,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                )
                              ],
                            )
                          ],
                        ),
                        subtitle: Text('Order Id: ${orderModel.orderId}'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
