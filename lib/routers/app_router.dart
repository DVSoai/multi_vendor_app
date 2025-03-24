import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_app/data/repositories/food/food_repository.dart';
import 'package:multi_vendor_app/pages/cart/cart_page.dart';
import 'package:multi_vendor_app/pages/categories/all_categories.dart';
import 'package:multi_vendor_app/pages/categories/category_page.dart';
import 'package:multi_vendor_app/pages/entrypoint/main_page.dart';
import 'package:multi_vendor_app/pages/home/bloc/home_bloc.dart';
import 'package:multi_vendor_app/pages/home/widgets/fastest_food/bloc/food_bloc.dart';
import 'package:multi_vendor_app/pages/home/widgets/nearby_restaurant/bloc/restaurant_bloc.dart';
import 'package:multi_vendor_app/pages/profile/profile_page.dart';
import 'package:multi_vendor_app/pages/search/search_page.dart';
import 'package:multi_vendor_app/routers/routers_name.dart';

import '../core/di/locator.dart';
import '../data/repositories/categories/category_repository.dart';
import '../pages/entrypoint/bloc/tab_index_bloc.dart';
import '../pages/home/widgets/fastest_food/all_fastest_foods.dart';
import '../pages/home/widgets/nearby_restaurant/all_nearby_restaurants.dart';
import '../pages/home/widgets/recommendations/recommendations.dart';
import '../pages/onboarding/on_boarding_page.dart';

class AppRouters {
  static final GoRouter router = GoRouter(
      initialLocation: RouterName.rootScreen,
      routes: [
        GoRoute(
          path: RouterName.onBoarding,
          builder: (context, state) => const OnBoardingPage(),
        ),
        //-----------------------Root-----------------------
        GoRoute(
          path: RouterName.rootScreen,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => TabIndexBloc(),
              child: MainPage(),
            );
          },
        ),


        //---------------Category----------------
        GoRoute(
          path: RouterName.categoryScreen,
          name: RouterName.categoryScreen,
          pageBuilder: (context, state) {
            final String category = state.extra as String;
            return CustomTransitionPage(
              child: BlocProvider(
                create: (_) => HomeBloc(sl<CategoryRepositoryRemote>(),sl<FoodRepositoryRemote>()),
                child: CategoryPage(category: category,),
              ),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(-1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          },
        ),
        GoRoute(
          path: RouterName.allCategoriesScreen,
          name: RouterName.allCategoriesScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: BlocProvider(
               create: (_) => HomeBloc(  sl<CategoryRepositoryRemote>(),sl<FoodRepositoryRemote>())..add(const GetListCategoriesAll()),
                child: const AllCategories(),
              ),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(-1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          },
        ),

        //---------------Bottom Navigation Bar----------------

        //---------------HomePage----------------
        // GoRoute(
        //     path: RouterName.homeScreen,
        //     builder: (context, state) {
        //       return BlocProvider(
        //         create: (_) => HomeBloc(),
        //         child: const HomePage(),
        //       );
        //     }),
        GoRoute(
          path: RouterName.allNearbyRestaurants,
          name: RouterName.allNearbyRestaurants,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child:BlocProvider(
                create: (_) => RestaurantBloc(sl<CategoryRepositoryRemote>())..add(const GetNearbyRestaurant()),
                child: const AllNearbyRestaurants(),
              ),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          },
        ),
        GoRoute(
          path: RouterName.recommendations,
          name: RouterName.recommendations,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const Recommendations(),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          },
        ),

        GoRoute(
          path: RouterName.allFastestFood,
          name: RouterName.allFastestFood,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: BlocProvider(
                create: (_) => FoodBloc(foodRepositoryRemote: sl<FoodRepositoryRemote>())..add(const GetAllFoods()),
                child: const AllFastestFoods(),
              ),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          },
        ),

        GoRoute(
            path: RouterName.searchScreen,
            builder: (context, state) {
              return const SearchPage();
            }),
        GoRoute(
            path: RouterName.cartScreen,
            builder: (context, state) {
              return const CartPage();
            }),
        GoRoute(
            path: RouterName.profileScreen,
            builder: (context, state) {
              return const ProfilePage();
            }),
      ],
      errorBuilder: (context, state) => Scaffold(
            body: Center(
              child: Text('No route defined for $state'),
            ),
          ),
      observers: [RouteObserver()]);
}
