import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_store/colors/colors.dart';

import 'package:shop_store/screens/favorite_screen/widget/favorite_single_item.dart';

import '../../provider/app_provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: black),
        title: Text(
          'Favorite Screen',
          style: header.copyWith(
            color: black,
            letterSpacing: 2,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: appProvider.getFavoriteProductList.isEmpty
            ? Image.asset(
                'assets/images/favorite.png',
                height: 550,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: appProvider.getFavoriteProductList.length,
                itemBuilder: (context, index) {
                  return FavoriteSingleItem(
                    singleProduct: appProvider.getFavoriteProductList[index],
                  );
                },
              ),
      ),
    );
  }
}
