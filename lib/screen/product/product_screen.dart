import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/models/models.dart';
import 'package:e_commerce_app/repository/blocs/cart/bloc/cart_bloc.dart';
import 'package:e_commerce_app/repository/blocs/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/widgets.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  static const String routeName = '/product';

  static Route route({required Product product}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => ProductScreen(product: product),
    );
  }

  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Product',
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
              BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context
                          .read<WishlistBloc>()
                          .add(AddWishlistProduct(product));

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Added to Wishlist',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: Colors.black),
                          ),
                          backgroundColor: Colors.white,
                          duration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      context
                          .read<CartBloc>()
                          .add(CartProductAdded(product: product));
                      Navigator.pushNamed(context, '/cart');
                    },
                    child: Text(
                      'ADD TO CART',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Colors.black,
                              ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.5,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: [
                HeroCarouselCard(product: product),
              ]),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  alignment: Alignment.bottomCenter,
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  width: MediaQuery.of(context).size.width - 10,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.white,
                              ),
                        ),
                        Text(
                          '\$${product.price}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text(
                'Product Information',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              children: [
                ListTile(
                  title: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget aliquet ultricies, nunc nisl aliquam nunc, quis aliquet nisl nunc quis nisl. Proin eget nisl eget nisl aliquam alique Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget aliquet ultricies, nunc nisl aliquam nunc, quis aliquet nisl nunc quis nisl. Proin eget nisl eget nisl aliquam alique',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
              title: Text(
                'Delivery Information',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              children: [
                ListTile(
                  title: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget aliquet ultricies, nunc nisl aliquam nunc, quis aliquet nisl nunc quis nisl. Proin eget nisl eget nisl aliquam alique Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget aliquet ultricies, nunc nisl aliquam nunc, quis aliquet nisl nunc quis nisl. Proin eget nisl eget nisl aliquam alique',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      /* HeroCarouselCard(product: product), */
    );
  }
}
