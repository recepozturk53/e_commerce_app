part of 'wishlist_bloc.dart';

sealed class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

final class WishlistLoading extends WishlistState {}

final class WishlistLoaded extends WishlistState {
  final WishList wishList;

  const WishlistLoaded({this.wishList = const WishList()});

  @override
  List<Object> get props => [wishList];
}

final class WishlistError extends WishlistState {}
