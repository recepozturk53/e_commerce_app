import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final bool isRecommended;
  final bool isPopular;

  const Product({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isRecommended,
    required this.isPopular,
  });

  @override
  List<Object?> get props => [
        name,
        category,
        imageUrl,
        price,
        isRecommended,
        isPopular,
      ];

  static List<Product> products = [
    const Product(
      name: 'Soft Drink #1',
      category: 'Soft Drink',
      imageUrl:
          'https://images.unsplash.com/photo-1621263764928-df1444c5e859?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80',
      price: 3.99,
      isRecommended: true,
      isPopular: false,
    ),
    const Product(
      name: 'Soft Drink #2',
      category: 'Soft Drink',
      imageUrl:
          'https://images.unsplash.com/photo-1533007716222-4b465613a984?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      price: 2.99,
      isRecommended: false,
      isPopular: false,
    ),
    const Product(
      name: 'Soft Drink #3',
      category: 'Soft Drink',
      imageUrl:
          'https://images.unsplash.com/photo-1583898350727-9bf2e476c242?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2576&q=80',
      price: 3.99,
      isRecommended: true,
      isPopular: true,
    ),
    const Product(
      name: 'Smoothies #1',
      category: 'Smoothies',
      imageUrl:
          'https://images.unsplash.com/photo-1586258148113-d9679ac30485?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2000&q=80',
      price: 5.99,
      isRecommended: true,
      isPopular: true,
    ),
    const Product(
      name: 'Smoothies #2',
      category: 'Smoothies',
      imageUrl:
          'https://images.unsplash.com/photo-1623065422902-30a2d299bbe4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      price: 4.99,
      isRecommended: false,
      isPopular: false,
    ),
  ];
}
