// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_store/models/product_models/product_models.dart';

import '../../../colors/colors.dart';
import '../../../constants/constant.dart';
import '../../../provider/app_provider.dart';

class CartSingleItem extends StatefulWidget {
  final ProductModel singleProduct;
  const CartSingleItem({
    Key? key,
    required this.singleProduct,
  }) : super(key: key);

  @override
  State<CartSingleItem> createState() => _CartSingleItemState();
}

class _CartSingleItemState extends State<CartSingleItem> {
  int qty = 1;

  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 1;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: liteyellow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 150,
              child: Image.network(
                widget.singleProduct.image,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: 150,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.singleProduct.name,
                      style: header.copyWith(
                        color: black,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            color: liteyellow,
                            height: 30,
                            width: 30,
                            child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Icon(
                                  Icons.remove,
                                  size: 25,
                                  color: black,
                                ),
                                onPressed: () {
                                  if (qty > 1) {
                                    setState(() {
                                      qty--;
                                    });
                                    //updated remove product quantity and reduce product cost
                                    appProvider.updateQty(
                                        widget.singleProduct, qty);
                                  }
                                }),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          qty.toString(),
                          style: textFont.copyWith(
                            color: black,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 12),
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            height: 30,
                            width: 30,
                            color: liteyellow,
                            child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Icon(
                                  Icons.add,
                                  size: 25,
                                  color: black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    qty++;
                                  });
                                  //update increament product count and total amount
                                  appProvider.updateQty(
                                      widget.singleProduct, qty);
                                }),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (!appProvider.getFavoriteProductList
                                .contains(widget.singleProduct)) {
                              appProvider
                                  .addFavoriteProduct(widget.singleProduct);
                              showMessage('Add to WishList');
                            } else {
                              appProvider
                                  .removeFavoriteProduct(widget.singleProduct);
                              showMessage('Add to WishList');
                            }
                          },
                          child: Text(
                            appProvider.getFavoriteProductList
                                    .contains(widget.singleProduct)
                                ? 'Remove to  wishlist'
                                : 'Add To Wishlist',
                            style: header.copyWith(
                              color: red,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            height: 35,
                            width: 35,
                            color: liteyellow,
                            child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Icon(
                                  Icons.delete,
                                  size: 25,
                                  color: red,
                                ),
                                onPressed: () {
                                  //Remove Provider values
                                  AppProvider appProvider =
                                      Provider.of<AppProvider>(context,
                                          listen: false);
                                  //Remove to cart Using Provider and compare widget.singleProduct
                                  appProvider
                                      .removeCartProduct(widget.singleProduct);
                                  showMessage('Removed From Cart');
                                }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30, top: 15),
            child: Text(
              '\$${widget.singleProduct.price.toString()}',
              style: header.copyWith(
                color: black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
