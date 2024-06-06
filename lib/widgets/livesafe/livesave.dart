import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fyp/widgets/livesafe/BusStationCard.dart';
import 'package:fyp/widgets/livesafe/PharmacyCard.dart';
import 'package:fyp/widgets/livesafe/PoliceStationCard.dart';
import 'package:fyp/widgets/livesafe/hospitalCard.dart';

class LiveSafe extends StatefulWidget {
  const LiveSafe({Key? key}) : super(key: key);

  @override
  _LiveSafeState createState() => _LiveSafeState();
}

class _LiveSafeState extends State<LiveSafe> {
  late Future<Position> _locationFuture;

  @override
  void initState() {
    super.initState();
    _locationFuture = _getCurrentLocation();
  }

  Future<Position> _getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error fetching location. Please check your settings.');
      rethrow;
    }
  }

  Future<void> _openMap(String location, Position userLocation) async {
    final lat = userLocation.latitude;
    final long = userLocation.longitude;

    final googleUrl =
        'https://www.google.com/maps/search/$location/@$lat,$long';

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not launch $googleUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'live Safe'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<Position>(
              future: _locationFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show placeholder content while waiting for location
                  return _buildLoadingContent();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final userLocation = snapshot.data!;
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      PoliceStationCard(
                          onMapFunction: (location) =>
                              _openMap(location, userLocation)),
                      HospitalCard(
                          onMapFunction: (location) =>
                              _openMap(location, userLocation)),
                      PharmacyCard(
                          onMapFunction: (location) =>
                              _openMap(location, userLocation)),
                      BusStationCard(
                          onMapFunction: (location) =>
                              _openMap(location, userLocation)),
                    ],
                  );
                } else {
                  return Text(
                      'Unable to fetch location'); // Placeholder for other error states
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingContent() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
