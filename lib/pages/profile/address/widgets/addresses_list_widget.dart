import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_app/core/constants/constants.dart';
import 'package:multi_vendor_app/data/models/address/address_model.dart';
import 'package:multi_vendor_app/pages/profile/address/bloc/address_bloc.dart';

import 'address_title.dart';

class AddressesListWidget extends StatelessWidget {
  const AddressesListWidget({super.key, required this.addresses});
  final List<AddressModel> addresses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context,index) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: kGray,
                    width: 0.5,
                  ),
                  top: BorderSide(
                    color: kGray,
                    width: 0.5,
                  ),
                )
            ),

            child: AddressTitle(address:addresses[index],),
          );
        }
    ) ;
  }
}
