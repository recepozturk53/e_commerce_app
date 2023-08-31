import 'dart:async';

import 'package:e_commerce_app/models/models.dart';
import 'package:e_commerce_app/repositories/category/category_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required CategoryRepo categoryRepo})
      : _categoryRepo = categoryRepo,
        super(CategoryLoading()) {
    on<LoadCategories>(_onLoadCategories);
    on<UpdateCategories>(_onUpdateCategories);
  }
  final CategoryRepo _categoryRepo;
  StreamSubscription? _categorySubscription;

  void _onLoadCategories(
      LoadCategories event, Emitter<CategoryState> emit) async {
    _categorySubscription?.cancel();
    _categorySubscription = _categoryRepo.getAllCategories().listen(
          (categories) => add(
            UpdateCategories(categories: categories),
          ),
        );
  }

  void _onUpdateCategories(
      UpdateCategories event, Emitter<CategoryState> emit) async {
    emit(CategoryLoaded(categories: event.categories));
  }
}
