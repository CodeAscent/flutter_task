import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_task/features/addProduct/add_product_screen.dart';
import 'package:flutter_task/features/shared_pref/products.dart';
import 'package:flutter_task/models/product_model.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  List<ProductModel> productsList = [];
  bool isLoading = false;
  getProducts() async {
    setState(() {
      isLoading = true;
    });
    productsList = await SharedPrefProducts().getProducts() ?? [];
    Future.delayed(Duration(seconds: 1)).whenComplete(() => setState(() {
          isLoading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi-Fi Shop & Service",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 28),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Audio on Rustavelie Ave 57. \nThis shop offers both products and services",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Wrap(
                        runSpacing: 20,
                        spacing: 20,
                        children: [
                          ...List.generate(productsList.length, (index) {
                            ProductModel product = productsList[index];
                            return Container(
                              width: Get.width * 0.42,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                          height: 140,
                                          width: 170,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: Image.file(
                                              File(product.image),
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                      Positioned(
                                          right: 10,
                                          top: 10,
                                          child: IconButton(
                                              onPressed: () async {
                                                await SharedPrefProducts()
                                                    .removeProduct(product.id);
                                                getProducts();
                                                setState(() {});
                                              },
                                              icon: Icon(Icons.delete_outline)))
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '\$' + "${product.price}.00",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddProductScreen())!.then((value) => setState(() {
                getProducts();
              }));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue.shade600,
      ),
    );
  }
}
