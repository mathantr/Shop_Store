import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_store/colors/colors.dart';
import 'package:shop_store/constants/constant.dart';
import 'package:shop_store/models/product_models/product_models.dart';
import 'package:shop_store/provider/app_provider.dart';
import 'package:shop_store/routes/routes.dart';
import 'package:shop_store/screens/cart_Screen.dart/cart_screen.dart';
import 'package:shop_store/screens/check_out/check_out.dart';
import 'package:shop_store/screens/favorite_screen/favorite_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productItem;
  const ProductDetailScreen({super.key, required this.productItem});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            CupertinoButton(
                child: Icon(
                  Icons.shopping_cart,
                  size: 35,
                  color: red,
                ),
                onPressed: () {
                  Routes.instance.push(CartScreen(), context);
                }),
            // CupertinoButton(
            //     child: Icon(
            //       Icons.favorite_border_outlined,
            //       size: 35,
            //       color: red,
            //     ),
            //     onPressed: () {
            //       Routes.instance.push(FavoriteScreen(), context);
            //     }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: FadeInUp(
              duration: Duration(seconds: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20.0),
                            alignment: Alignment.topCenter,
                            height: 250.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.elliptical(45, 35),
                                bottomRight: Radius.elliptical(45, 35),
                              ),
                              color: liteyellow,
                            ),
                            //child: Image.asset("assets/bgImage.jpg"),
                          ),
                          Container(
                              //color: Colors.white,

                              width: 400.0,
                              padding:
                                  EdgeInsets.only(top: 85, left: 55, right: 55),
                              child: Container(
                                  height: 250,
                                  width: 250,
                                  child: Image.network(
                                    widget.productItem.image,
                                    fit: BoxFit.cover,
                                  ))),
                        ],
                      ),
                    ]),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.productItem.name,
                                style: header.copyWith(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    letterSpacing: 2),
                              ),
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: Icon(
                                      appProvider.getFavoriteProductList
                                              .contains(widget.productItem)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: red,
                                      size: 35,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        widget.productItem.isFavorite =
                                            !widget.productItem.isFavorite;
                                      });
                                      if (widget.productItem.isFavorite) {
                                        appProvider.addFavoriteProduct(
                                            widget.productItem);
                                      } else {
                                        appProvider.removeFavoriteProduct(
                                            widget.productItem);
                                      }
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 150,
                                  child: Text(
                                    'Price:',
                                    style: header.copyWith(
                                        color: red,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        letterSpacing: 2),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Text(
                                '\$${widget.productItem.price.toString()}',
                                style: header.copyWith(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    letterSpacing: 2),
                              ),
                            ],
                          ),
                          Text(
                            widget.productItem.description,
                            textAlign: TextAlign.justify,
                            style: textFont.copyWith(
                              fontSize: 20,
                              height: 2,
                              letterSpacing: 2,
                            ),
                          ),
                          SizedBox(
                            height: 15,
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
                                  height: 45,
                                  width: 45,
                                  child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      child: Icon(
                                        Icons.remove,
                                        size: 35,
                                        color: black,
                                      ),
                                      onPressed: () {
                                        if (qty > 1) {
                                          setState(() {
                                            qty--;
                                          });
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
                                  height: 45,
                                  width: 45,
                                  color: liteyellow,
                                  child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      child: Icon(
                                        Icons.add,
                                        size: 35,
                                        color: black,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          qty++;
                                        });
                                      }),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 175,
                                  color: liteyellow,
                                  child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        //get Provider values

                                        //copy with get qty values

                                        ProductModel productModel = widget
                                            .productItem
                                            .copyWith(qty: qty);
                                        //Add to cart Using Provider and compare widget.productItem
                                        appProvider
                                            .addCartProduct(productModel);
                                        showMessage('Added to Cart');
                                      },
                                      child: Text(
                                        'Add To Cart',
                                        style: header.copyWith(
                                            color: black,
                                            letterSpacing: 2,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 20),
                                      )),
                                ),
                              ),
                              Card(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 175,
                                  color: liteBlack,
                                  child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        ProductModel productModel = widget
                                            .productItem
                                            .copyWith(qty: qty);
                                        Routes.instance.push(
                                            CheckOut(
                                                singleProduct: productModel),
                                            context);
                                      },
                                      child: Text(
                                        'Buy',
                                        style: header.copyWith(
                                            color: red,
                                            letterSpacing: 2,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 25),
                                      )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
