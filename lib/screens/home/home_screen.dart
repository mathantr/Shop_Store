import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_store/colors/colors.dart';
import 'package:shop_store/provider/app_provider.dart';
import 'package:shop_store/routes/routes.dart';
import 'package:shop_store/screens/category_view/category_view_screen.dart';
import 'package:shop_store/screens/product_details/product_details.dart';
import 'package:shop_store/widgets/top_titles/top_titles.dart';

import '../../firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import '../../models/category_models/category_models.dart';
import '../../models/product_models/product_models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getbestProducts();

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
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(
                  top: 0, right: 20, left: 20, bottom: 58),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: kToolbarHeight,
                        ),
                        Text(
                          'Store',
                          style: header.copyWith(
                              color: black,
                              fontWeight: FontWeight.w800,
                              fontSize: 28,
                              letterSpacing: 3),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Categories',
                      style: header.copyWith(
                        color: black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    categoriesList.isEmpty
                        ? const Center(
                            child: Text("Categories is empty"),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Row(
                              children: categoriesList
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          Routes.instance.push(
                                              CategoryViewScreen(
                                                  categoryModel: e),
                                              context);
                                        },
                                        child: Card(
                                          color: liteBlack,
                                          elevation: 3.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Image.network(
                                              e.image,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Top Selling',
                      style: header.copyWith(
                        color: black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    productModelList.isEmpty
                        ? const Center(
                            child: Text("Best product is empty"),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: productModelList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: MediaQuery.of(context)
                                            .size
                                            .width /
                                        (MediaQuery.of(context).size.height /
                                            1.5),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      // OutlinedButton(
                                      //   onPressed: () {},
                                      //   child: Text(
                                      //     'Buy',
                                      //     style: header.copyWith(
                                      //       color: black,
                                      //       fontWeight: FontWeight.w700,
                                      //       fontSize: 18,
                                      //     ),
                                      //   ),
                                      // ),

                                      Container(
                                        height: 30,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(5),
                                                bottomLeft: Radius.circular(5),
                                                bottomRight:
                                                    Radius.circular(20)),
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
                                                        productModelList[
                                                            index]),
                                                context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                  ],
                ),
              ),
            ),
    );
  }
}
