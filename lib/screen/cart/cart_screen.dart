import 'package:e_commerce_app/repository/blocs/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/widgets.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CartScreen(),
    );
  }

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Cart',
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Go To Checkout',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.cart.freeDeliveryString,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Add More Items',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(color: Colors.white),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 330,
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return CartProductCard(
                                product: state.cart
                                    .productQuantity(state.cart.products)
                                    .keys
                                    .elementAt(index),
                                quantity: state.cart
                                    .productQuantity(state.cart.products)
                                    .values
                                    .elementAt(index),
                              );
                            },
                            itemCount: state.cart
                                .productQuantity(state.cart.products)
                                .keys
                                .length,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Divider(
                          thickness: 2.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'SUBTOTAL',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  Text(
                                    '\$${state.cart.subtotalString}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'DELIVERY FEE',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  Text(
                                    '\$${state.cart.deliveryFeeString}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black.withAlpha(50),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              margin: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'TOTAL',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      '\$${state.cart.totalString}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ));
  }
}
