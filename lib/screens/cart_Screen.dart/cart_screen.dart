import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_store/colors/colors.dart';
import 'package:shop_store/constants/constant.dart';
import 'package:shop_store/routes/routes.dart';
import 'package:shop_store/screens/add_to_cart_checkout/add_to_cart_checkout.dart';
import 'package:shop_store/screens/cart_Screen.dart/widget/cart_single_item.dart';
import 'package:shop_store/screens/check_out/check_out.dart';

import '../../provider/app_provider.dart';
import '../../widgets/primary_button/primary_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      bottomNavigationBar: Container(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pay Online',
                    style: header.copyWith(
                      color: black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '\$${appProvider.totalPrice().toString()}',
                    style: header.copyWith(
                      color: black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              PrimaryButton(
                  onPressed: () {
                    appProvider.ClearBuyProduct();
                    appProvider.addBuyCartProduct();
                    appProvider.ClearCart();
                    if (appProvider.getBuyProductList.isEmpty) {
                      showMessage('Cart is Empty');
                    } else {
                      Routes.instance.push(AddToCartCheckOut(), context);
                    }
                  },
                  title: 'Check Out'),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: black),
        title: Text(
          'Add to Cart',
          style: header.copyWith(
            color: black,
            letterSpacing: 2,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: appProvider.getCartProductList.isEmpty
            ? Image.asset(
                'assets/images/cart_empty.png',
              )
            : ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: appProvider.getCartProductList.length,
                itemBuilder: (context, index) {
                  return CartSingleItem(
                    singleProduct: appProvider.getCartProductList[index],
                  );
                },
              ),
      ),
    );
  }
}
