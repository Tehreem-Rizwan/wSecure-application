import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PharmacyCard extends StatelessWidget {
  final Function(String)? onMapFunction;

  const PharmacyCard({Key? key, this.onMapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapFunction?.call('Pharmacies near me');
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Image.asset(
                    'assets/images/pharmacy.png',
                    height: 32,
                  ),
                ),
              ),
            ),
          ),
          Text(
            'pharmacy'.tr,
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
