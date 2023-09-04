import 'package:e_commerce_app/blocs/cart/bloc/cart_bloc.dart';
import 'package:e_commerce_app/screen/checkout/checkout_screen.dart';
import 'package:e_commerce_app/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/widgets.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const CheckoutScreen()));
                  },
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const HomeScreen()));
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
                              return ProductCard.cart(
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
                    const OrderSummary(),
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
