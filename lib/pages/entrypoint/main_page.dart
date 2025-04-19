//ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:multi_vendor_app/data/repositories/food/food_repository.dart';
import 'package:multi_vendor_app/pages/auth/widgets/login_redirect.dart';
import 'package:multi_vendor_app/pages/cart/cart_page.dart';
import 'package:multi_vendor_app/pages/home/bloc/home_bloc.dart';
import 'package:multi_vendor_app/pages/home/home_page.dart';
import 'package:multi_vendor_app/pages/profile/bloc/profile_bloc.dart';
import 'package:multi_vendor_app/pages/search/bloc/search_bloc.dart';
import 'package:multi_vendor_app/pages/search/search_page.dart';

import '../../core/constants/constants.dart';
import '../../core/di/locator.dart';
import '../../core/network/local/global_storage.dart';
import '../../data/repositories/address/addresses_repository.dart';
import '../../data/repositories/auth/email_verification/email_verification_repository.dart';
import '../../data/repositories/cart/cart_repository.dart';
import '../../data/repositories/categories/category_repository.dart';
import '../../data/repositories/search/search_repository.dart';
import '../auth/login/email_verification/bloc/email_verification_bloc.dart';
import '../auth/login/email_verification/email_verification.dart';
import '../cart/bloc/cart_bloc.dart';
import '../profile/profile_page.dart';
import 'bloc/tab_index_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabIndexBloc, TabIndexState>(
      builder: (context, state) {
        final token = sl<GlobalStorage>().userToken;
        final user = sl<GlobalStorage>().user;
        List<Widget> pages = [
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => HomeBloc(
                  sl<CategoryRepositoryRemote>(),
                  sl<FoodRepositoryRemote>(),
                  sl<AddressesRepositoryRemote>(),
                )..add(const GetListCategories()),
              ),
              BlocProvider(
                lazy: false,
                create: (_) => ProfileBloc(),
              ),
              // ✅ Dùng lại CartBloc đã được cung cấp từ ShellRoute
              BlocProvider.value(
                value: context.read<CartBloc>(),
              ),
            ],
            child: const HomePage(),
          ),
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => SearchBloc(
                  sl<SearchRepositoryRemote>(),
                ),
              ),
              BlocProvider.value(
                value: context.read<CartBloc>(),
              ),
            ],
            child: const SearchPage(),
          ),
          token == null
              ? const LoginRedirect()
              : user != null && user.verification == false
              ? BlocProvider(
            create: (context) => EmailVerificationBloc(
              sl<EmailVerificationRepositoryRemote>(),
              sl<GlobalStorage>(),
            ),
            child: const EmailVerification(),
          )
              : BlocProvider.value(
            value: context.read<CartBloc>(),
            child: const CartPage(),
          ),
          token == null || user != null && user.verification == false
              ? const LoginRedirect()
              : user != null && user.verification == false
              ? BlocProvider(
            create: (context) => EmailVerificationBloc(
              sl<EmailVerificationRepositoryRemote>(),
              sl<GlobalStorage>(),
            ),
            child: const EmailVerification(),
          )
              : BlocProvider(
            create: (context) => ProfileBloc(),
            child: const ProfilePage(),
          ),
        ];

        return Scaffold(
          body: Stack(
            children: [
              pages[state.index],
              Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                    data: Theme.of(context).copyWith(canvasColor: kPrimary),
                    child: BottomNavigationBar(
                      elevation: 0,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      selectedIconTheme: const IconThemeData(color: kSecondary),
                      unselectedIconTheme:
                          const IconThemeData(color: Colors.black38),
                      onTap: (index) {
                        context
                            .read<TabIndexBloc>()
                            .add(TabIndexChanged(index));
                      },
                      currentIndex: state.index,
                      items: [
                        BottomNavigationBarItem(
                          icon: state.index == 0
                              ? const Icon(AntDesign.appstore1)
                              : const Icon(AntDesign.appstore_o),
                          label: 'Home',
                        ),
                        const BottomNavigationBarItem(
                          icon: Icon(Icons.search),
                          label: 'Search',
                        ),
                        BottomNavigationBarItem(
                          icon: BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) {
                              final count = state.listCart.length;
                              return Badge(
                                label: Text('$count'),
                                child: const Icon(FontAwesome.opencart),
                              );
                            },
                          ),
                          label: 'Cart',
                        ),
                        BottomNavigationBarItem(
                          icon: state.index == 3
                              ? const Icon(FontAwesome.user_circle)
                              : const Icon(FontAwesome.user_circle_o),
                          label: 'Profile',
                        ),
                      ],
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}
