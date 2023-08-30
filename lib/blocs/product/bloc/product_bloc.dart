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
        super(ProductLoading());
  final ProductRepo _productRepo;
  StreamSubscription? _productSubscription;

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is LoadProducts) {
      yield* _mapLoadProductsToState();
    }
    if (event is UpdateProducts) {
      yield* _mapUpdateProductsToState(event);
    }
  }

  Stream<ProductState> _mapLoadProductsToState() async* {
    _productSubscription?.cancel();
    _productSubscription = _productRepo.getAllProducts().listen(
          (products) => add(
            UpdateProducts(products: products),
          ),
        );
  }

  Stream<ProductState> _mapUpdateProductsToState(UpdateProducts event) async* {
    yield ProductLoaded(products: event.products);
  }

  /* {
    on<ProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  } */
}
