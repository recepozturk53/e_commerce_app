import 'package:e_commerce_app/models/models.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double radiusFactor;
  const ProductCard({
    super.key,
    required this.product,
    this.radiusFactor = 80,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/product', arguments: product),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CircleAvatar(
            radius: radiusFactor,
            backgroundImage: NetworkImage(
              product.imageUrl,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular((radiusFactor * 1.25)),
            ),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_outlined,
                        color: Colors.white70,
                        size: 24,
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
