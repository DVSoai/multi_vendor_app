import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_vendor_app/common/app_style.dart';
import 'package:multi_vendor_app/common/reusable_text.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/pages/home/bloc/home_bloc.dart';

import '../pages/profile/bloc/profile_bloc.dart';


class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  @override
  void initState() {
    super.initState();
    _determinePosition(context);
   context.read<HomeBloc>().add(const LoadDefaultAddress());
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 6.h),
      height: 110.h,
      width: width,
      color: kOffWhite,
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: kSecondary,
            backgroundImage: const AssetImage('assets/images/avatar.jpg'),
          ),
            Padding(
              padding: EdgeInsets.only(bottom: 6.h,left: 6.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 ReusableText(text: 'Deliver to', style: appStyle(13, kSecondary, FontWeight.w600)),
                  SizedBox(
                    width: width*0.65,
                    child: BlocBuilder<HomeBloc,HomeState>(
                        builder:(context,state){
                          return Text(
                           state.defaultAddress != null ?  state.defaultAddress!.addressLine1 : 'No Address',
                            overflow: TextOverflow.ellipsis,
                            style: appStyle(11, kGrayLight, FontWeight.normal),
                          );
                        }
                    )

                  ),


                ],
              ),
            ),
             Text(getTimeOfDay(),style: const TextStyle(fontSize: 35),)
          ],

        ),
      ),
    );
  }
}

String getTimeOfDay(){
  DateTime now = DateTime.now();
  int hour = now.hour;
  if(hour >=0 && hour < 12){
    return '☀️';
  }else if(hour >= 12 && hour < 16){
    return '🌤';
  } else{
    return '🌙';
  }
}

Future<void> _determinePosition(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  _getCurrentLocation(context);

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.

}

Future<void>_getCurrentLocation(BuildContext context) async {

  Position position = await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 10,
  ));
  // Use the position data
  LatLng latLng = LatLng(position.latitude, position.longitude);
  context.read<ProfileBloc>().add(UpdatePositionEvent(latLng));
  context.read<ProfileBloc>().add(GetUserAddressEvent(latLng));
  // For example, print the latitude and longitude
  print(latLng);
}
