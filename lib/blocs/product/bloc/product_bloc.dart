import 'dart:async';

import 'package:e_commerce_app/models/models.dart';
import 'package:e_commerce_app/repositories/product/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required ProductRepo productRepo})
      : _productRepo = productRepo,
        super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<UpdateProducts>(_onUpdateProducts);
  }
  final ProductRepo _productRepo;
  StreamSubscription? _productSubscription;

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    _productSubscription?.cancel();
    _productSubscription = _productRepo.getAllProducts().listen(
          (products) => add(
            UpdateProducts(products: products),
          ),
        );
  }

  void _onUpdateProducts(
      UpdateProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoaded(products: event.products));
  }
}
