import 'package:e_commerce_app/blocs/blocs.dart';
import 'package:e_commerce_app/config/theme.dart';
import 'package:e_commerce_app/repositories/category/category_repo.dart';
import 'package:e_commerce_app/repositories/product/product_repo.dart';
import 'package:e_commerce_app/screen/screens.dart';
import 'package:e_commerce_app/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repositories/checkout/checkout_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WishlistBloc()..add(LoadWishlist())),
        BlocProvider(create: (_) => CartBloc()..add(LoadCart())),
        BlocProvider(
          create: (context) => CheckoutBloc(
            cartBloc: context.read<CartBloc>(),
            checkoutRepository: CheckoutRepository(),
          ),
        ),
        BlocProvider(
            create: (_) => CategoryBloc(categoryRepo: CategoryRepo())
              ..add(LoadCategories())),
        BlocProvider(
            create: (_) =>
                ProductBloc(productRepo: ProductRepo())..add(LoadProducts())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: const SplashScreen(),
      ),
    );
  }
}
