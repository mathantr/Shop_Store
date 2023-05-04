// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shop_store/models/category_models/category_models.dart';
import 'package:shop_store/widgets/top_titles/top_titles.dart';

import '../../colors/colors.dart';
import '../../firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import '../../models/product_models/product_models.dart';
import '../../routes/routes.dart';
import '../product_details/product_details.dart';

class CategoryViewScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryViewScreen({
    Key? key,
    required this.categoryModel,
  }) : super(key: key);

  @override
  State<CategoryViewScreen> createState() => _CategoryViewScreenState();
}

class _CategoryViewScreenState extends State<CategoryViewScreen> {
  List<ProductModel> productModelList = [];
  bool isLoading = false;
  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    productModelList.shuffle();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.categoryModel.name.toUpperCase(),
              style: header.copyWith(
                color: black,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                fontSize: 22,
              ),
            ),
            productModelList.isEmpty
                ? const Center(
                    child: Text("Best product is empty"),
                  )
                : SingleChildScrollView(
                    child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: productModelList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.5),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(20),
                            ),
                            color: liteyellow.withOpacity(0.9),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: Column(
                              children: [
                                Image.network(
                                  productModelList[index].image,
                                  height: 100,
                                  width: double.infinity,
                                ),
                                Spacer(),
                                Text(
                                  productModelList[index].name,
                                  textAlign: TextAlign.justify,
                                  style: header.copyWith(
                                    color: black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Price',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: header.copyWith(
                                        color: black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      '\$${productModelList[index].price}',
                                      style: header.copyWith(
                                        color: black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(20)),
                                      color: red),
                                  child: CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      'Buy',
                                      style: header.copyWith(
                                          color: white,
                                          fontSize: 16,
                                          wordSpacing: 1.2,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 2),
                                    ),
                                    onPressed: () {
                                      Routes.instance.push(
                                          ProductDetailScreen(
                                              productItem:
                                                  productModelList[index]),
                                          context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
