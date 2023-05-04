import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_store/colors/colors.dart';
import 'package:shop_store/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:shop_store/models/product_models/product_models.dart';
import 'package:shop_store/screens/bottom_navigator/bottom_navigator.dart';
import 'package:shop_store/widgets/primary_button/primary_button.dart';

import '../../provider/app_provider.dart';
import '../../routes/routes.dart';

class AddToCartCheckOut extends StatefulWidget {
  const AddToCartCheckOut({
    super.key,
  });

  @override
  State<AddToCartCheckOut> createState() => _AddToCartCheckOutState();
}

class _AddToCartCheckOutState extends State<AddToCartCheckOut> {
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: black),
        title: Text(
          'Check Out',
          style: header.copyWith(
              color: black,
              fontSize: 22,
              letterSpacing: 2,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.5,
                    color: black,
                  )
                ],
                borderRadius: BorderRadius.circular(20),
                color: liteyellow,
              ),
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.5,
                    color: black,
                  )
                ],
                borderRadius: BorderRadius.circular(20),
                color: liteyellow,
              ),
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Pay Online",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            PrimaryButton(
                onPressed: () async {
                  bool value = await FirebaseFirestoreHelper.instance
                      .uploadOrderedProductFirebase(
                          appProvider.getBuyProductList,
                          context,
                          groupValue == 1 ? 'Cash on delivery' : 'paid');

                  appProvider.ClearBuyProduct();
                  if (value) {
                    Future.delayed(Duration(seconds: 2), () {
                      Routes.instance.push(BottomNavigator(), context);
                    });
                  }
                },
                title: 'Continue'),
          ],
        ),
      ),
    );
  }
}
