import 'package:e_commerce_app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading());

  @override
  Stream<WishlistState> mapEventToState(
    WishlistEvent event,
  ) async* {
    if (event is StartWishList) {
      yield* _mapStartWishListToState();
    } else if (event is AddWishlistProduct) {
      yield* _mapAddWishlistProductToState(event, state);
    } else if (event is RemoveWishlistProduct) {
      yield* _mapRemoveWishlistProductToState(event, state);
    }
  }

  Stream<WishlistState> _mapStartWishListToState() async* {
    yield const WishlistLoaded();

    try {
      await Future.delayed(const Duration(seconds: 1));
      yield const WishlistLoaded();
    } catch (_) {
      yield WishlistError();
    }
  }

  Stream<WishlistState> _mapAddWishlistProductToState(
      AddWishlistProduct event, WishlistState state) async* {
    if (state is WishlistLoaded) {
      try {
        final List<Product> updatedProducts = List.from(state.wishList.products)
          ..add(event.product);
        yield WishlistLoaded(wishList: WishList(products: updatedProducts));
      } catch (_) {
        yield WishlistError();
      }
    }
  }

  Stream<WishlistState> _mapRemoveWishlistProductToState(
      RemoveWishlistProduct event, WishlistState state) async* {
    if (state is WishlistLoaded) {
      try {
        final List<Product> updatedProducts = List.from(state.wishList.products)
          ..remove(event.product);
        yield WishlistLoaded(wishList: WishList(products: updatedProducts));
      } catch (_) {
        yield WishlistError();
      }
    }
  }

  /* {
    on<WishlistEvent>((event, emit) {
      if(event is StartWishList){
        
      }
    });
  } */
}
