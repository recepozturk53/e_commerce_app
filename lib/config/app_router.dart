/* import 'package:e_commerce_app/models/models.dart';
import 'package:e_commerce_app/screen/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  /// This is not working properly I dont use it anymore
  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return const HomeScreen();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'catalog',
                name: 'catalog',
                builder: (BuildContext context, GoRouterState state) {
                  return CatalogScreen(
                    category: state.extra as Category,
                  );
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'product',
                    name: 'product',
                    builder: (BuildContext context, GoRouterState state) {
                      return ProductScreen(
                        product: state.extra as Product,
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'wishlist',
                name: 'wishlist',
                builder: (BuildContext context, GoRouterState state) {
                  return const WishlistScreen();
                },
              ),
            ],
          ),
          GoRoute(
            path: 'cart',
            name: 'cart',
            builder: (BuildContext context, GoRouterState state) {
              return const CartScreen();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'checkout',
                name: 'checkout',
                builder: (BuildContext context, GoRouterState state) {
                  return const CheckoutScreen();
                },
              ),
            ],
          ),
          GoRoute(
            path: 'person',
            builder: (BuildContext context, GoRouterState state) {
              return const CartScreen();
            },
          ),
        ],
      ),
    ],
  );
}
 */