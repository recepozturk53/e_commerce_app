import 'package:e_commerce_app/blocs/cart/bloc/cart_bloc.dart';
import 'package:e_commerce_app/blocs/checkout/bloc/checkout_bloc.dart';
import 'package:e_commerce_app/blocs/wishlist/bloc/wishlist_bloc.dart';
import 'package:e_commerce_app/screen/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/models.dart';

class CustomNavBar extends StatelessWidget {
  final String screen;
  final Product? product;

  const CustomNavBar({
    Key? key,
    required this.screen,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 70,
        child: (screen == '/product')
            ? AddToCartNavBar(product: product!)
            : (screen == '/cart')
                ? const GoToCheckoutNavBar()
                : (screen == '/checkout')
                    ? const OrderNowNavBar()
                    : const HomeNavBar(),
      ),
    );
  }
}

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(
            Icons.home,
            color: Color(0xFFFF9900),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const HomeScreen()));
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            color: Color(0xFFFF9900),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const CartScreen()));
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.person,
            color: Color(0xFFFF9900),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const HomeScreen()));
          },
        )
      ],
    );
  }
}

class AddToCartNavBar extends StatelessWidget {
  const AddToCartNavBar({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () {},
        ),
        BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return const CircularProgressIndicator();
            }
            if (state is WishlistLoaded) {
              return IconButton(
                icon: const Icon(Icons.favorite, color: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added to your Wishlist!'),
                    ),
                  );
                  /*  context
                      .read<WishlistBloc>()
                      .add(AddProductToWishlist(product)); */
                },
              );
            }
            return const Text('Something went wrong!');
          },
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const CircularProgressIndicator();
            }
            if (state is CartLoaded) {
              return ElevatedButton(
                onPressed: () {
                  /*  context.read<CartBloc>().add(AddProduct(product)); */
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const CartScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(),
                ),
                child: Text(
                  'ADD TO CART',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              );
            }
            return const Text('Something went wrong!');
          },
        ),
      ],
    );
  }
}

class GoToCheckoutNavBar extends StatelessWidget {
  const GoToCheckoutNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const CheckoutScreen()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(),
          ),
          child: Text(
            'GO TO CHECKOUT',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ],
    );
  }
}

class OrderNowNavBar extends StatelessWidget {
  const OrderNowNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*  NavigationHelper.initialize(context); */ // NavigationHelper'ı başlat
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CheckoutLoaded) {
              return ElevatedButton(
                onPressed: () {
                  context
                      .read<CheckoutBloc>()
                      .add(ConfirmCheckout(checkout: state.checkout));

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OrderConfirmation(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(),
                ),
                child: Text(
                  'ORDER NOW',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ],
    );
  }
}
