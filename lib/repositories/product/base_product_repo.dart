import 'package:e_commerce_app/models/models.dart';

abstract class BaseProductRepo {
  Stream<List<Product>> getAllProducts();
}
