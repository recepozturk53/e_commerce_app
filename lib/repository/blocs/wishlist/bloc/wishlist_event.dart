part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class StartWishList extends WishlistEvent {}

class AddWishlistProduct extends WishlistEvent {
  final Product product;

  const AddWishlistProduct(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveWishlistProduct extends WishlistEvent {
  final Product product;

  const RemoveWishlistProduct(this.product);

  @override
  List<Object> get props => [product];
}
