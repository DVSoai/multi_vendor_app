//ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:multi_vendor_app/pages/cart/cart_page.dart';
import 'package:multi_vendor_app/pages/home/home_page.dart';
import 'package:multi_vendor_app/pages/search/search_page.dart';

import '../../core/constants/constants.dart';
import '../profile/profile_page.dart';
import 'bloc/tab_index_bloc.dart';

class MainPage extends StatelessWidget {
   MainPage({super.key});

   List<Widget> pages = [
   const  HomePage(),
     const SearchPage(),
     const CartPage(),
     const  ProfilePage(),
   ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabIndexBloc, TabIndexState>(
      builder: (context, state) {
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
                      unselectedIconTheme: const IconThemeData(color: Colors.black38),
                      onTap: (index) {
                        context.read<TabIndexBloc>().add(TabIndexChanged(index));
                      },
                      currentIndex: state.index,
                      items:  [
                        BottomNavigationBarItem(
                          icon: state.index == 0 ? const Icon(AntDesign.appstore1) :const Icon(AntDesign.appstore_o),
                          label: 'Home',
                        ),
                       const BottomNavigationBarItem(
                          icon: Icon(Icons.search),
                          label: 'Search',
                        ),
                      const  BottomNavigationBarItem(
                          icon:Badge(
                            label: Text('3'),
                            child: Icon(FontAwesome.opencart),
                          ),
                          label: 'Cart',
                        ),
                        BottomNavigationBarItem(
                          icon: state.index == 3 ? const Icon(FontAwesome.user_circle) :const Icon(FontAwesome.user_circle_o),
                          label: 'Profile',
                        ),
                      ],
                    )
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
