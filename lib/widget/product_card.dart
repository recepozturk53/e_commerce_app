import 'package:e_commerce_app/blocs/cart/bloc/cart_bloc.dart';
import 'package:e_commerce_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double radiusFactor;
  final bool isWishList;
  const ProductCard({
    super.key,
    required this.product,
    this.radiusFactor = 80,
    this.isWishList = false,
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
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is CartLoaded) {
                      return Flexible(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(CartProductAdded(product: product));
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              color: Color(0xFFFF9900),
                              size: 24,
                            )),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                !isWishList
                    ? const SizedBox.shrink()
                    : Flexible(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
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
