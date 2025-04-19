import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_vendor_app/common/app_loader.dart';
import 'package:multi_vendor_app/common/back_ground_container.dart';
import 'package:multi_vendor_app/common/custom_button.dart';
import 'package:multi_vendor_app/common/email_text_field.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/pages/profile/bloc/profile_bloc.dart';
import 'package:multi_vendor_app/pages/profile/shipping/bloc/shipping_bloc.dart';

import '../../../common/app_style.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  final PageController _pageController = PageController(initialPage: 0);
  GoogleMapController? _mapController;
  bool _isMapReady = false;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();
  final TextEditingController _instructions = TextEditingController();
  LatLng? _selectedPosition;
  List<dynamic> _placeList = [];
  final List<dynamic> _selectedPlace = [];

  final dio = Dio();
  Timer? _debounce;

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
    _pageController.dispose();
    _searchController.dispose();
    _postalCode.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () async {
      if (query.isNotEmpty) {
        final url =
            'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$googleApiKey';
        try {
          final response = await dio.get(url);
          if (response.statusCode == 200) {
            final data = response.data;
            setState(() {
              _placeList = data['predictions'];
            });
          } else {
            setState(() {
              _placeList = [];
            });
          }
        } catch (e) {
          debugPrint("Error during search: $e");
        }
      } else {
        setState(() {
          _placeList = [];
        });
      }
    });
  }

  void _getPlaceDetails(String placeId) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;
        final location = data['result']['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];
        final address = data['result']['formatted_address'];

        String postalCode = '';
        final addressComponents = data['result']['address_components'];
        for (var component in addressComponents) {
          if (component['types'].contains('postal_code')) {
            postalCode = component['long_name'];
            break;
          }
        }

        // Nếu không tìm thấy postal_code trong place details → fallback sang reverse geocoding
        if (postalCode.isEmpty) {
          final reverseUrl =
              'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleApiKey';
          final reverseResponse = await dio.get(reverseUrl);

          if (reverseResponse.statusCode == 200) {
            final results = reverseResponse.data['results'];
            for (var result in results) {
              for (var component in result['address_components']) {
                if (component['types'].contains('postal_code')) {
                  postalCode = component['long_name'];
                  break;
                }
              }
              if (postalCode.isNotEmpty) break;
            }
          }
        }

        setState(() {
          _selectedPosition = LatLng(lat, lng);
          _searchController.text = address;
          _postalCode.text = postalCode;
          _placeList = [];
        });

        debugPrint('postalCode: ${_postalCode.text}');

        WidgetsBinding.instance.addPostFrameCallback((_) {
          moveToSelectedPosition();
        });
      }
    } catch (e) {
      debugPrint('Error fetching place details: $e');
    }
  }

  void moveToSelectedPosition() {
    if (_isMapReady && _mapController != null && _selectedPosition != null) {
      try {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _selectedPosition!,
              zoom: 15,
            ),
          ),
        );
      } catch (e, s) {
        debugPrint('Error animating camera: $e');
        debugPrintStack(stackTrace: s);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShippingBloc, ShippingState>(
      listener: (context, state) {
        if (state.isLoading == true) {
          return AppLoader.show(context);
        } else {
          AppLoader.hide();
        }
        if (state.isSuccess == true) {
         context.pop(true);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Thêm địa chỉ thành công ')));
        } else if (state.isError == true) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: BlocBuilder<ShippingBloc, ShippingState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: EdgeInsets.only(right: 0.w),
                  child: state.tabIndex == 0
                      ? IconButton(
                          icon: const Icon(
                            AntDesign.closecircleo,
                            color: kRed,
                          ),
                          onPressed: () {
                            context.pop();
                          },
                        )
                      : IconButton(
                          icon: const Icon(
                            AntDesign.leftcircleo,
                            color: kDark,
                          ),
                          onPressed: () {
                            context
                                .read<ShippingBloc>()
                                .add(const ChangeTabEvent(0));
                            _pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                        ),
                ),
                title: const Text('Shipping Address'),
                centerTitle: true,
                backgroundColor: kOffWhite,
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 0,
                actions: [
                  state.tabIndex == 1
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: IconButton(
                            onPressed: () {
                              context
                                  .read<ShippingBloc>()
                                  .add(const ChangeTabEvent(1));
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            },
                            icon: const Icon(
                              AntDesign.rightcircleo,
                              color: kDark,
                            ),
                          ),
                        )
                ],
              ),
              body: SizedBox(
                width: width,
                height: height,
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  pageSnapping: false,
                  onPageChanged: (index) {
                    // Handle page change if needed
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  children: [
                    Stack(children: [
                      GoogleMap(
                        onMapCreated: (GoogleMapController controller) {
                          _mapController = controller;
                          _isMapReady = true;
                        },
                        initialCameraPosition: CameraPosition(
                          target: _selectedPosition ??
                              const LatLng(
                                  20.97096063081741, 105.8683156594634),
                          zoom: 15,
                        ),
                        markers: _selectedPosition == null
                            ? {
                                Marker(
                                  markerId: const MarkerId('selected-location'),
                                  position: const LatLng(20.9714, 105.8643),
                                  draggable: true,
                                  onDragEnd: (LatLng position) {
                                    context
                                        .read<ProfileBloc>()
                                        .add(GetUserAddressEvent(position));
                                    setState(() {
                                      _selectedPosition = position;
                                    });
                                  },
                                ),
                              }
                            : {
                                Marker(
                                  markerId: const MarkerId('selected-location'),
                                  position: _selectedPosition!,
                                  draggable: true,
                                  onDragEnd: (LatLng position) {
                                    context
                                        .read<ProfileBloc>()
                                        .add(GetUserAddressEvent(position));
                                    setState(() {
                                      _selectedPosition = position;
                                    });
                                  },
                                ),
                              },
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            color: kOffWhite,
                            child: TextField(
                              controller: _searchController,
                              onChanged: _onSearchChanged,
                              decoration: const InputDecoration(
                                hintText: 'Search for your address ...',
                              ),
                            ),
                          ),
                          _placeList.isEmpty
                              ? const SizedBox.shrink()
                              : Expanded(
                                  child: ListView(
                                    children: List.generate(_placeList.length,
                                        (index) {
                                      return Container(
                                        color: Colors.white,
                                        child: ListTile(
                                          visualDensity: VisualDensity.compact,
                                          title: Text(
                                            _placeList[index]['description'],
                                            // style: appStyle(
                                            //     14, kGrayLight, FontWeight.w400),
                                          ),
                                          onTap: () async {
                                            debugPrint(
                                                'Place ID: ${_placeList[index]['place_id']}');
                                            _getPlaceDetails(
                                                _placeList[index]['place_id']);
                                            _selectedPlace
                                                .add(_placeList[index]);
                                          },
                                        ),
                                      );
                                    }),
                                  ),
                                )
                        ],
                      ),
                    ]),
                    BackGroundContainer(
                      color: kLightWhite,
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        children: [
                          Gap(30.h),
                          EmailTextField(
                            controller: _searchController,
                            hintText: 'Address',
                            keyboardType: TextInputType.number,
                            prefixIcon: const Icon(
                              Ionicons.location_sharp,
                              color: kDark,
                            ),
                          ),
                          Gap(15.h),
                          EmailTextField(
                            controller: _postalCode,
                            hintText: 'Postal Code',
                            keyboardType: TextInputType.number,
                            prefixIcon: const Icon(
                              Ionicons.location_sharp,
                              color: kDark,
                            ),
                          ),
                          Gap(8.h),
                          Text(
                            maxLines: 3,
                            "Lưu ý: Một số khu vực không có mã bưu chính trong Google Maps.Bạn có thể tìm mã bưu chính trên các trang web như Tổng công ty Bưu điện Việt Nam.",
                            style: appStyle(12, kGrayLight, FontWeight.w400),
                          ),
                          Gap(15.h),
                          EmailTextField(
                            controller: _instructions,
                            hintText: 'Delivery Instructions',
                            prefixIcon: const Icon(
                              Ionicons.add_circle,
                              color: kDark,
                            ),
                          ),
                          CheckboxListTile(
                            checkColor: kOffWhite,
                            contentPadding: EdgeInsets.zero,
                            activeColor: kPrimary,
                            value: state.isDefault,
                            onChanged: (value) {
                              context.read<ShippingBloc>().add(
                                  CheckDefaultAddressEvent(value ?? false));
                            },
                            title: const Text('Set as default address'),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          Gap(15.h),
                          CustomButton(
                            onPressed: () {
                              if (_searchController.text.isNotEmpty &&
                                  _postalCode.text.isNotEmpty &&
                                  _instructions.text.isNotEmpty) {
                                context
                                    .read<ShippingBloc>()
                                    .add(AddShippingAddressEvent(address: {
                                      "addressLine1": _searchController.text,
                                      "postalCode": _postalCode.text,
                                      "default": state.isDefault,
                                      "deliveryInstructions":
                                          _instructions.text,
                                      "latitude": _selectedPosition!.latitude,
                                      "longitude": _selectedPosition!.longitude
                                    }));
                              }else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Vui lòng nhập đủ thông tin địa chi ")),
                                );
                              }
                            },
                            btnHeight: 45.h,
                            text: 'S U B M I T',
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
