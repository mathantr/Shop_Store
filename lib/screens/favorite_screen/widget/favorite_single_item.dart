// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_store/models/product_models/product_models.dart';

import '../../../colors/colors.dart';
import '../../../constants/constant.dart';
import '../../../provider/app_provider.dart';

class FavoriteSingleItem extends StatefulWidget {
  final ProductModel singleProduct;
  const FavoriteSingleItem({
    Key? key,
    required this.singleProduct,
  }) : super(key: key);

  @override
  State<FavoriteSingleItem> createState() => _FavoriteSingleItemState();
}

class _FavoriteSingleItemState extends State<FavoriteSingleItem> {
  @override
  Widget build(BuildContext context) {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            AppProvider appProvider = Provider.of<AppProvider>(
                                context,
                                listen: false);
                            //Remove to cart Using Provider and compare widget.singleProduct
                            appProvider
                                .removeFavoriteProduct(widget.singleProduct);
                            showMessage('Removed to  Wishlist');
                          },
                          child: Text(
                            'Remove To WishList',
                            style: header.copyWith(
                              color: red,
                              fontSize: 18,
                            ),
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
