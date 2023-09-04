import 'package:e_commerce_app/models/models.dart';
import 'package:flutter/material.dart';

import '../../widget/widgets.dart';

class CatalogScreen extends StatelessWidget {
  final Category category;
  static const String routeName = '/catalog';

  const CatalogScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final List<Product> categoryProducts = Product.products
        .where((product) => product.category == category.name)
        .toList();
    return Scaffold(
        appBar: CustomAppBar(
          title: category.name,
        ),
        bottomNavigationBar: const CustomNavBar(
          screen: routeName,
        ),
        body: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.15),
            itemCount: categoryProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ProductCard.catalog(
                    product: categoryProducts[index],
                    radiusFactor: 5,
                  ),
                ),
              );
            }));
  }
}
