import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/models/models.dart';
import 'package:flutter/material.dart';

import '../../widget/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Zero To Unicorn',
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.5,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: Category.categories
                  .map((category) => HeroCarouselCard(category: category))
                  .toList(),
            ),
            const SectionTitle(
              title: 'RECOMMENDED',
            ),
            ProductCarousel(
              products: Product.products
                  .where((product) => product.isRecommended)
                  .toList(),
            ),
            const SectionTitle(
              title: 'Most Popular',
            ),
            ProductCarousel(
              products: Product.products
                  .where((product) => product.isPopular)
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
