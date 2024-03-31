import 'dart:convert';

import 'package:flutter_task/models/product_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefProducts {
  Future saveProducts(ProductModel product) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> productsList =
        await sharedPreferences.getStringList("product") ?? [];
    productsList.add(jsonEncode(product));
    sharedPreferences.setStringList("product", productsList);
    print(productsList);
  }

  Future<List<ProductModel>?>? getProducts() async {
    List<ProductModel> products = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? productsList =
        await sharedPreferences.getStringList("product");
    if (productsList != []) {
      for (var item in productsList!) {
        products.add(ProductModel.fromJson(jsonDecode(item)));
      }
    }
    return products;
  }

  removeProduct(productId) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      List<String> productsList = [];
      List<ProductModel>? products = await getProducts();
      products!.removeWhere((element) => element.id == productId);
      for (var item in products) {
        productsList.add(jsonEncode(item));
      }
      print(productsList);
      await sharedPreferences.setStringList("product", productsList);
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
