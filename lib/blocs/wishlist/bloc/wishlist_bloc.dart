import 'package:e_commerce_app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<LoadWishlist>(_onLoadWishlist);
    on<AddProductToWishlist>(_onAddWishlistProduct);
    on<RemoveProductFromWishlist>(_onRemoveWishlistProduct);
  }

  void _onLoadWishlist(LoadWishlist event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(const WishlistLoaded());
    } catch (_) {
      emit(WishlistError());
    }
  }

  void _onAddWishlistProduct(
      AddProductToWishlist event, Emitter<WishlistState> emit) async {
    final state = this.state;
    if (state is WishlistLoaded) {
      try {
        emit(WishlistLoaded(
            wishList: WishList(
                products: List.from(state.wishList.products)
                  ..add(event.product))));
      } catch (_) {
        emit(WishlistError());
      }
    }
  }

  void _onRemoveWishlistProduct(
      RemoveProductFromWishlist event, Emitter<WishlistState> emit) async {
    final state = this.state;
    if (state is WishlistLoaded) {
      try {
        emit(WishlistLoaded(
            wishList: WishList(
                products: List.from(state.wishList.products)
                  ..remove(event.product))));
      } catch (_) {
        emit(WishlistError());
      }
    }
  }
}
