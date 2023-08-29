import 'package:e_commerce_app/models/models.dart';
import 'package:e_commerce_app/widget/widgets.dart';
import 'package:flutter/material.dart';

class ProductCarousel extends StatelessWidget {
  final List<Product> products;
  const ProductCarousel({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: ProductCard(
              product: products[index],
            ),
          );
        },
      ),
    );
  }
}
