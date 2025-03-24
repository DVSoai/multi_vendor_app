import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:multi_vendor_app/common/custom_text_Widget.dart';
import 'package:multi_vendor_app/core/shimmers/foodlist_shimmer.dart';
import 'package:multi_vendor_app/pages/search/bloc/search_bloc.dart';
import 'package:multi_vendor_app/pages/search/widgets/search_loading_widget.dart';
import 'package:multi_vendor_app/pages/search/widgets/search_not_empty.dart';
import 'package:multi_vendor_app/pages/search/widgets/search_results.dart';

import '../../common/custom_container.dart';
import '../../core/constants/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: kPrimary,
        appBar: AppBar(
          toolbarHeight: 74.h,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: CustomTextWidget(
              controller: _searchController,
              keyboardType: TextInputType.text,
              hintText: 'Search For Food',
              suffixIcon: GestureDetector(
                  onTap: () {
                    if (state.searchResults == null) {
                      context
                          .read<SearchBloc>()
                          .add(SearchFoods(query: _searchController.text));
                    } else {
                      context.read<SearchBloc>().add(const ClearSearchResults());
                      _searchController.clear();

                    }
                  },
                  child: state.searchResults == null
                      ? const Icon(
                          Ionicons.search_circle,
                          color: kPrimary,
                          size: 40,
                        )
                      : const Icon(
                          Ionicons.close_circle,
                          color: kRed,
                          size: 40,
                        )),
            ),
          ),
        ),
        body: SafeArea(
          child: CustomContainer(
            color: Colors.white,
            containerContent: state.isLoading
                ? const FoodsListShimmer()
                : state.searchResults == null ? const SearchLoadingWidget(): const SearchResults(),
          ),
        ),
      );
    });
  }
}
