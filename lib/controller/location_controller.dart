import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dirise/utils/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/add_current_address_model.dart';
import '../model/common_modal.dart';
import '../repository/repository.dart';
import 'cart_controller.dart';

class LocationController extends GetxController {
  RxBool servicestatus = false.obs;
  RxBool haspermission = false.obs;
  bool isChoose = false;
  late LocationPermission permission;
  String? _address = "";
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  Position? _currentPosition;  late Position position;
  RxString long = "".obs, lat = "".obs;
  var locality = 'No location set'.obs;
  var country = 'Getting Country..'.obs;
  late StreamSubscription<Position> positionStream;
  String street = '';
  // RxString city = ''.obs;
  RxString city = ''.obs;
  String state = '';
  String countryName = '';
  // RxString zipcode = ''.obs;
  RxString zipcode = ''.obs;
  String town = '';
  RxString cityHome = ''.obs;
  checkGps(context) async {
    servicestatus.value = await Geolocator.isLocationServiceEnabled();
    if (servicestatus.value) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.denied) {
          haspermission.value = true;
        }
      } else {
        haspermission.value = true;
      }

      if (haspermission.value) {
        getLocation();
        // editAddressApi();
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              "Location",
            ),
            content: const Text(
              "Please turn on GPS location service to narrow down the nearest Cooks.",
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await Geolocator.openLocationSettings();
                  servicestatus.value =
                  await Geolocator.isLocationServiceEnabled();
                  if (servicestatus.value) {
                    permission = await Geolocator.checkPermission();

                    if (permission == LocationPermission.denied) {
                      permission = await Geolocator.requestPermission();
                      if (permission == LocationPermission.denied) {
                      } else if (permission ==
                          LocationPermission.deniedForever) {
                      } else {
                        haspermission.value = true;
                      }
                    } else {
                      haspermission.value = true;
                    }

                    if (haspermission.value) {
                      getLocation();
                      // editAddressApi();
                    }
                  }
                },
              ),
            ],
          ));
    }
  }
  final cartController = Get.put(CartController());
  final Repositories repositories = Repositories();
  Rx<AddCurrentAddressModel> addCurrentAddress = AddCurrentAddressModel().obs;
  editAddressApi(context) {
    Map<String, dynamic> map = {};
      map['zip_code'] =  zipcodeController.text;
    print(map.toString());
    repositories.postApi(url: ApiUrls.addCurrentAddress, mapData: map,context: context).then((value) {
      addCurrentAddress.value = AddCurrentAddressModel.fromJson(jsonDecode(value));
      showToast(addCurrentAddress.value.message.toString());
      city.value = addCurrentAddress.value.data!.city;
      zipcode.value = addCurrentAddress.value.data!.state;
      cartController.countryId =  addCurrentAddress.value.data!.countryId.toString();
      cartController.getCart();
      zipcodeController.clear();
      Get.back();
    });
  }
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
     showToast('Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
       showToast('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
     showToast('Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }
  final Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? mapController;
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      // setState(() =>
      _currentPosition = position;
      // );
      _getAddressFromLatLng(_currentPosition!);
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude), zoom: 15)));
      // _onAddMarkerButtonPressed(LatLng(_currentPosition!.latitude, _currentPosition!.longitude), "current location");
      // setState(() {});
      // location = _currentAddress!;
    }).catchError((e) {
      debugPrint(e);
    });
  }
  Future<void> _getAddressFromLatLng(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];

      // setState(() {
        street = placemark.street ?? '';
        city.value = placemark.locality ?? '';
        state = placemark.administrativeArea ?? '';
        countryName = placemark.country ?? '';
        zipcode.value = placemark.postalCode ?? '';
        town = placemark.subAdministrativeArea ?? '';
    print('object ${street.toString()}');
      // });
    }
    await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      // setState(() {
        _address = '${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      // });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }
  Future getLocation() async {
    log("Getting user location.........");
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    long.value = position.longitude.toString();
    lat.value = position.latitude.toString();
    await placemarkFromCoordinates(
        double.parse(lat.value), double.parse(long.value))
        .then((value) async {
      locality.value = value.last.locality!;
      country.value = 'Country : ${value.last.country}';
      // await updateLocation(
      //   latitude: lat.toString(),
      //   longitude: long.toString(),
      // );
      //     .then((value) {
      //   log("+++++++++${value.message!}");
      //   if(value.status == true){
      //     final homepageController1 = Get.put(HomePageController1());
      //     homepageController1.getHomePageData().then((value) {
      //       final storeController = Get.put(StoreController());
      //       storeController.isPaginationLoading.value = true;
      //       storeController.loadMore.value = true;
      //       storeController.getData(isFirstTime: true);
      //     });
      //   }
      // });
    });
  }

  getApiLocation() async {
    log("Getting user location.........");
    await placemarkFromCoordinates(
        double.parse(lat.value == '' ? "0" : lat.value),
        double.parse(long.value == '' ? "0" : long.value))
        .then((value) {
      locality.value = 'Locality: ${value.first.locality}';
      country.value = 'Country : ${value.last.country}';
      log(value.map((e) => e.locality).toList().toString());
      log(locality.value);
      log(country.value);
    });
  }



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkGps(Get.context);
  }
}
