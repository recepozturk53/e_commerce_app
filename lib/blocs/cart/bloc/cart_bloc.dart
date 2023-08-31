import 'package:e_commerce_app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
  }

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(const CartLoaded());
    } catch (_) {
      emit(CartError());
    }
  }

  void _onAddProduct(AddProduct event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(CartLoaded(
            cart: Cart(
                products: List.from(state.cart.products)..add(event.product))));
      } catch (_) {
        emit(CartError());
      }
    }
  }

  void _onRemoveProduct(RemoveProduct event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(CartLoaded(
            cart: Cart(
                products: List.from(state.cart.products)
                  ..remove(event.product))));
      } catch (_) {
        emit(CartError());
      }
    }
  }
}
