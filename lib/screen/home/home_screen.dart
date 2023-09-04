import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/blocs/blocs.dart';
import 'package:e_commerce_app/screen/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final user = context.select((AppBloc bloc) => bloc.state.userModel);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFF9900),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'AzamonBucks',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.white,
                    ),
              )),
          iconTheme: const IconThemeData(color: Color(0xFFFF9900)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const WishlistScreen()));
                },
                icon: const Icon(Icons.favorite, color: Color(0xFFFF9900))),
            IconButton(
                onPressed: () {
                  context.read<AppBloc>().add(AppLogoutRequested());
                  /* Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const LoginScreen())); */
                },
                icon: const Icon(Icons.exit_to_app, color: Color(0xFFFF9900))),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        bottomNavigationBar: const CustomNavBar(
          screen: routeName,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // get categories with bloc from firestore
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CategoryLoaded) {
                    return CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1.5,
                        viewportFraction: 0.9,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),
                      items: state.categories
                          .map((category) =>
                              HeroCarouselCard(category: category))
                          .toList(),
                    );
                  } else {
                    return const Center(child: Text('Something went wrong'));
                  }
                },
              ),
              const SectionTitle(
                title: 'RECOMMENDED',
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProductLoaded) {
                    return ProductCarousel(
                      products: state.products
                          .where((product) => product.isRecommended)
                          .toList(),
                    );
                  } else {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  }
                },
              ),
              const SectionTitle(
                title: 'Most Popular',
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProductLoaded) {
                    return ProductCarousel(
                      products: state.products
                          .where((product) => product.isPopular)
                          .toList(),
                    );
                  } else {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
