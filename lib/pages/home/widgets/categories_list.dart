
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_app/core/shimmers/categories_shimmer.dart';
import '../../../common/app_style.dart';
import '../../../common/reusable_text.dart';
import '../../../core/constants/constants.dart';
import '../../../routers/routers_name.dart';
import '../bloc/home_bloc.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc,HomeState>(
      listenWhen: (previous, current) => previous.title != current.title,
      listener: (context, state) {
        if (state.title == 'More') {
          context.read<HomeBloc>().add(
              const UpdateCategoryAndTitle(category: '', title: ''));
          context.pushNamed(RouterName.allCategoriesScreen);
        }
      },
      child:  BlocBuilder<HomeBloc,HomeState>(
        builder: (context, state){
         if(state.isLoading == true){
           return const CatergoriesShimmer();
         }else {
           return Container(
             height: 80.h,
             padding: EdgeInsets.only(left: 12.w, top: 10.h),
             child: ListView(
               scrollDirection: Axis.horizontal,
               children: List.generate(
                   state.listCategory.length, (i) {
                 final category = state.listCategory[i];
                 return GestureDetector(
                   onTap: () {
                     if (state.category == category.id) {
                       context.read<HomeBloc>().add(
                           const UpdateCategoryAndTitle(category: '', title: ''));
                     }else {
                       debugPrint('Category: ${category.id}');
                       context.read<HomeBloc>().add(UpdateCategoryAndTitle(
                           category: category.id, title: category.title));
                       context.read<HomeBloc>().add(GetFoodsAll(
                           code: '41007428', category: category.id,title: category.title));
                     }
                   },
                   child: Container(
                     margin: EdgeInsets.only(right: 5.w),
                     padding: EdgeInsets.only(top: 4.h),
                     width: width * 0.19,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10.r),
                       border: Border.all(color: state.category == category.id ? kSecondary : kOffWhite, width: .5.w),

                     ),
                     child: Column(
                       children: [
                         SizedBox(
                           height: 35,
                           child: Image.network(
                             category.imageUrl,
                             fit: BoxFit.contain,
                           ),
                         ),
                         ReusableText(
                             text: category.title,
                             style: appStyle(12, kDark, FontWeight.normal)),
                       ],
                     ),
                   ),
                 );
               }),
             ),
           );
         }
        },
      ),
    );
  }
}

