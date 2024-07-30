import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:developer';

import '../model/common_modal.dart';
import '../repository/repository.dart';
import '../utils/api_constant.dart';

class ControllerMap extends GetxController {
  final Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? mapController;

  var lastMapPosition = LatLng(0, -0).obs; // Example initial position
  RxString address = ''.obs;
  RxString street = ''.obs;
  RxString city = ''.obs;
  RxString state = ''.obs;
  RxString country = ''.obs;
  RxString zipcode = ''.obs;
  RxString town = ''.obs;
  RxString countryCode = ''.obs;
  var redPinMarker = Marker(markerId: MarkerId('redPin')).obs;
  var isMarkerDraggable = true.obs;
  final Repositories repositories = Repositories();



  sellingPickupAddressApi(context) {
    Map<String, dynamic> map = {};

    map['address_type'] = 'shipping';
    map['city'] =city.toString();
    map['country'] = country.toString();
    map['state'] = state.toString();
    map['zip_code'] = zipcode.toString();
    map['town'] = town.toString();
    map['street'] = street.toString();
    map['country_sort_name'] = countryCode.toString();



    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.editAddressUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        showToast(response.message.toString());
        Get.back();
      }
    });
  }
  sellingPickupAddressApi1(context) {
    Map<String, dynamic> map = {};

    map['address_type'] = 'shipping';
    map['city'] =city.toString();
    map['country'] = country.toString();
    map['state'] = state.toString();
    map['zip_code'] = zipcode.toString();
    map['town'] = town.toString();
    map['street'] = street.toString();

    map['country_sort_name'] = countryCode.toString();

    FocusManager.instance.primaryFocus!.unfocus();
    repositories.postApi(url: ApiUrls.editAddressUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        showToast(response.message.toString());
        // Get.back();
      }
    });
  }




  @override
  void onInit() {
    super.onInit();
    getAddressFromLatLng(lastMapPosition.value, 'Initial Marker', allowZoomIn: true);
  }

  Future<void> getAddressFromLatLng(LatLng lastMapPosition, markerTitle, {allowZoomIn = true}) async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      lastMapPosition.latitude,
      lastMapPosition.longitude,
    );
    if (placemarks.isNotEmpty) {
      final Placemark placemark = placemarks[0];

      String houseNo = '';
      String streetNo = '';
      String blockNo = '';
      String city = placemark.locality ?? '';

      // Example regex patterns for house number and street components
      final housePattern = RegExp(r'\d+\s*\w*');
      final streetPattern = RegExp(r'(?<=\d\s).+'); // Assumes street name follows house number

      // Extracting house number
      if (placemark.street != null) {
        final houseMatch = housePattern.firstMatch(placemark.street!);
        if (houseMatch != null) {
          houseNo = houseMatch.group(0) ?? '';
        }

        // Extracting street name
        final streetMatch = streetPattern.firstMatch(placemark.street!);
        if (streetMatch != null) {
          streetNo = streetMatch.group(0) ?? '';
        }
      }

      // Assuming block information might be part of subLocality or another component
      if (placemark.subLocality != null) {
        blockNo = placemark.subLocality!;
      }

      address.value = '${houseNo},${placemark.thoroughfare}, ${blockNo}, ${city}, ${placemark.country}';
      street.value = placemark.street ?? '';
      this.city.value = city;
      state.value = placemark.administrativeArea ?? '';
      country.value = placemark.country ?? '';
      zipcode.value = placemark.postalCode ?? '';
      town.value = placemark.subLocality ?? '';
      countryCode.value = placemark.isoCountryCode ?? '';

      log('House No: $houseNo');
      log('Street No: $streetNo');
      log('Block No: $blockNo');
      log('City: $city');

      log(placemark.subLocality.toString());
      log(placemark.country.toString());
      log(placemark.street.toString());
      log(placemark.locality.toString());
      log(placemark.name.toString());
      log(placemark.administrativeArea.toString());
      log(placemark.subThoroughfare.toString());
      log(placemark.thoroughfare.toString());
      log(placemark.subAdministrativeArea.toString());
      log(placemark.postalCode.toString());
      log("code"+placemark.isoCountryCode.toString());
    }

    redPinMarker.value = Marker(
      markerId: MarkerId('redPin'),
      position: lastMapPosition,
      draggable: isMarkerDraggable.value,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    if (googleMapController.isCompleted) {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: lastMapPosition, zoom: allowZoomIn ? 13 : 10),
        ),
      );
    }
  }
}
