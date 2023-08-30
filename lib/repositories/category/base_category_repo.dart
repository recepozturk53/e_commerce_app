import 'package:e_commerce_app/models/models.dart';

abstract class BaseCategoryRepo {
  Stream<List<Category>> getAllCategories();
}
