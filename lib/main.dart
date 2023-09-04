import 'package:e_commerce_app/blocs/blocs.dart';
import 'package:e_commerce_app/config/routes.dart';
import 'package:e_commerce_app/config/theme.dart';
import 'package:e_commerce_app/repositories/auth/auth_repository.dart';
import 'package:e_commerce_app/repositories/category/category_repo.dart';
import 'package:e_commerce_app/repositories/product/product_repo.dart';
import 'package:e_commerce_app/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repositories/checkout/checkout_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final authRepository = AuthRepository();
  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;
  const MyApp({super.key, required AuthRepository authRepository})
      : _authRepository = authRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => _authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AppBloc(authRepository: _authRepository)),
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
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: FlowBuilder(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
