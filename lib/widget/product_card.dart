import 'package:e_commerce_app/blocs/blocs.dart';
import 'package:e_commerce_app/models/models.dart';
import 'package:e_commerce_app/screen/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double radiusFactor;
  final double height;
  final bool isCatalog;
  final bool isWishlist;
  final bool isCart;
  final bool isSummary;
  final Color iconColor;
  final Color fontColor;
  final int? quantity;

/*   const ProductCard({
    super.key,
    required this.product,
    this.radiusFactor = 80,
    this.isWishList = false,
  }); */

  const ProductCard.catalog({
    Key? key,
    required this.product,
    this.quantity,
    this.radiusFactor = 4.5,
    this.height = 150,
    this.isCatalog = true,
    this.isWishlist = false,
    this.isCart = false,
    this.isSummary = false,
    this.iconColor = const Color(0xFFFF9900),
    this.fontColor = Colors.white,
  }) : super(key: key);

  const ProductCard.wishlist({
    Key? key,
    required this.product,
    this.quantity,
    this.radiusFactor = 4.5,
    this.height = 150,
    this.isCatalog = false,
    this.isWishlist = true,
    this.isCart = false,
    this.isSummary = false,
    this.iconColor = const Color(0xFFFF9900),
    this.fontColor = Colors.white,
  }) : super(key: key);

  const ProductCard.cart({
    Key? key,
    required this.product,
    this.quantity,
    this.radiusFactor = 0.1,
    this.height = 80,
    this.isCatalog = false,
    this.isWishlist = false,
    this.isCart = true,
    this.isSummary = false,
    this.iconColor = const Color(0xFFFF9900),
    this.fontColor = Colors.black,
  }) : super(key: key);

  const ProductCard.summary({
    Key? key,
    required this.product,
    this.quantity,
    this.radiusFactor = 2.25,
    this.height = 80,
    this.isCatalog = false,
    this.isWishlist = false,
    this.isCart = false,
    this.isSummary = true,
    this.iconColor = const Color(0xFFFF9900),
    this.fontColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double adjWidth = width / radiusFactor;
    return InkWell(
      onTap: () {
        if (isCatalog || isWishlist) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductScreen(
                    product: product,
                  )));
        }
      },
      child: isCart || isSummary
          ? Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  ProductImage(
                    adjWidth: 60,
                    height: height,
                    product: product,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ProductInformation(
                      product: product,
                      fontColor: fontColor,
                      quantity: quantity,
                      isOrderSummary: isSummary ? true : false,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ProductActions(
                    product: product,
                    isCatalog: isCatalog,
                    isWishlist: isWishlist,
                    isCart: isCart,
                    iconColor: iconColor,
                    quantity: quantity,
                  )
                ],
              ),
            )
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ProductImage(
                  adjWidth: adjWidth,
                  height: height,
                  product: product,
                ),
                ProductBackground(
                  adjWidth: adjWidth,
                  widgets: [
                    ProductInformation(
                      product: product,
                      fontColor: fontColor,
                    ),
                    ProductActions(
                      product: product,
                      isCatalog: isCatalog,
                      isWishlist: isWishlist,
                      isCart: isCart,
                      iconColor: iconColor,
                    )
                  ],
                ),
              ],
            ),
    );
  }
}

/* color: Color(0xFFFF9900), */

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key? key,
    required this.adjWidth,
    required this.height,
    required this.product,
  }) : super(key: key);

  final double adjWidth;
  final double height;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: adjWidth,
      backgroundImage: NetworkImage(
        product.imageUrl,
      ),
    );
  }
}

class ProductInformation extends StatelessWidget {
  const ProductInformation({
    Key? key,
    required this.product,
    required this.fontColor,
    this.isOrderSummary = false,
    this.quantity,
  }) : super(key: key);

  final Product product;
  final Color fontColor;
  final bool isOrderSummary;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: fontColor,
                  ),
            ),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: fontColor,
                  ),
            ),
          ],
        ),
        isOrderSummary
            ? Text(
                'Qty. $quantity',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: fontColor),
              )
            : const SizedBox(),
      ],
    );
  }
}

class ProductActions extends StatelessWidget {
  const ProductActions({
    Key? key,
    required this.product,
    required this.isCatalog,
    required this.isWishlist,
    required this.isCart,
    required this.iconColor,
    this.quantity,
  }) : super(key: key);

  final Product product;
  final bool isCatalog;
  final bool isWishlist;
  final bool isCart;
  final Color iconColor;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
        if (state is CartLoaded) {
          IconButton addProduct = IconButton(
            icon: Icon(
              Icons.add_circle,
              color: iconColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to your Cart!'),
                  backgroundColor: Color(0xFFFF9900),
                ),
              );
              context.read<CartBloc>().add(AddProduct(product: product));
            },
          );

          IconButton removeProduct = IconButton(
            icon: Icon(
              Icons.remove_circle,
              color: iconColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Removed from your Cart!'),
                ),
              );
              context.read<CartBloc>().add(RemoveProduct(product: product));
            },
          );

          IconButton removeFromWishlist = IconButton(
            icon: Icon(
              Icons.delete,
              color: iconColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Removed from your Wishlist!'),
                ),
              );
              context
                  .read<WishlistBloc>()
                  .add(RemoveProductFromWishlist(product));
            },
          );

          Text productQuantity = Text(
            '$quantity',
            style: Theme.of(context).textTheme.headlineMedium,
          );

          if (isCatalog) {
            return Row(children: [addProduct]);
          } else if (isWishlist) {
            return Row(children: [addProduct, removeFromWishlist]);
          } else if (isCart) {
            return Row(children: [removeProduct, productQuantity, addProduct]);
          } else {
            return const SizedBox();
          }
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }
}

class ProductBackground extends StatelessWidget {
  const ProductBackground({
    Key? key,
    required this.adjWidth,
    required this.widgets,
  }) : super(key: key);

  final double adjWidth;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular((adjWidth * 1.25)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [...widgets],
        ),
      ),
    );
  }
}
