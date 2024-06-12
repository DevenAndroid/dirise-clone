import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/location_controller.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/dimension_screen.dart';
import '../controller/service_controller.dart';
import '../model/model_address_list.dart';
import '../screens/check_out/address/edit_address.dart';
import 'Edit_find_location_edit.dart';

class FindMyLocationAddress extends StatefulWidget {
  FindMyLocationAddress({
    super.key,
  });
  static var FindMyLocationAddressScreen = "/FindMyLocationAddressScreen";
  static String route = "/FindMyLocationAddress";
  @override
  State<FindMyLocationAddress> createState() => _FindMyLocationAddressState();
}

class _FindMyLocationAddressState extends State<FindMyLocationAddress> {
  final Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? mapController;

  String? _address = "";
  Position? _currentPosition;
  final serviceController = Get.put(ServiceController());
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude), zoom: 15)));
      _onAddMarkerButtonPressed(LatLng(_currentPosition!.latitude, _currentPosition!.longitude), "current location");
      setState(() {});
      // location = _currentAddress!;
    }).catchError((e) {
      debugPrint(e);
    });
  }

  String? street;
  String? city;
  String? state;
  String? country;
  String? zipcode;
  String? town;

  Future<void> _getAddressFromLatLng(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];

      setState(() {
        street = placemark.street ?? '';
        city = placemark.locality ?? '';
        state = placemark.administrativeArea ?? '';
        country = placemark.country ?? '';
        zipcode = placemark.postalCode ?? '';
        town = placemark.subAdministrativeArea ?? '';
      });
    }
    await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _address = '${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  String? appLanguage = "English";
  getLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    appLanguage = sharedPreferences.getString("app_language");
    print("hfgdhfgh$appLanguage");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getLanguage();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCurrentPosition();
    });
  }

  String googleApikey = "AIzaSyDXySHy9RuRf6UJmcS1E57SZjdi08NWFxA";
  GoogleMapController? mapController1;
  CameraPosition? cameraPosition;
  String location = "Search Location";
  bool isMarkerDraggable = true;
  Marker? redPinMarker;
  final Set<Marker> markers = {};
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<void> _onAddMarkerButtonPressed(LatLng lastMapPosition, markerTitle, {allowZoomIn = true}) async {
    final Uint8List markerIcon = await getBytesFromAsset('assets/icons/location.png', 140);

    redPinMarker = Marker(
      markerId: MarkerId('redPin'),
      position: lastMapPosition,
      draggable: isMarkerDraggable,
    
      onDragStart: (newPosition) async {
        setState(() {
          redPinMarker = redPinMarker!.copyWith(positionParam: newPosition);
        });

        // Fetch the address based on the new marker position
        final List<Placemark> placemarks = await placemarkFromCoordinates(newPosition.latitude, newPosition.longitude);
        if (placemarks.isNotEmpty) {
          final Placemark placemark = placemarks[0];
          setState(() {
            _address = '${placemark.subLocality}, ${placemark.subAdministrativeArea}, ${placemark.postalCode}';
          });
        }
      },
      onDrag: (newPosition) async {
        setState(() {
          redPinMarker = redPinMarker!.copyWith(positionParam: newPosition);
        });

        // Fetch the address based on the new marker position
        final List<Placemark> placemarks = await placemarkFromCoordinates(newPosition.latitude, newPosition.longitude);
        if (placemarks.isNotEmpty) {
          final Placemark placemark = placemarks[0];
          setState(() {
            _address = '${placemark.subLocality}, ${placemark.subAdministrativeArea}, ${placemark.postalCode}';
          });
        }
      },
      onDragEnd: (newPosition) async {
        setState(() {
          redPinMarker = redPinMarker!.copyWith(positionParam: newPosition);
        });

        // Fetch the address based on the new marker position
        final List<Placemark> placemarks = await placemarkFromCoordinates(newPosition.latitude, newPosition.longitude);
        if (placemarks.isNotEmpty) {
          final Placemark placemark = placemarks[0];
          setState(() {
            _address = '${placemark.subLocality}, ${placemark.subAdministrativeArea}, ${placemark.postalCode}';
          });
        }
      },
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    if (googleMapController.isCompleted) {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: lastMapPosition, zoom: allowZoomIn ? 14 : 11)),
      );
    }
    setState(() {});
  }


  // Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  // }
  //
  // Future<void> _onAddMarkerButtonPressed(LatLng lastMapPosition, markerTitle, {allowZoomIn = true}) async {
  //   final Uint8List markerIcon = await getBytesFromAsset('assets/icons/location.png', 140);
  //   markers.clear();
  //   markers.add(Marker(
  //       markerId: MarkerId(lastMapPosition.toString()),
  //       position: lastMapPosition,
  //       infoWindow: const InfoWindow(
  //         title: "",
  //       ),
  //       icon: BitmapDescriptor.fromBytes(markerIcon)));
  //   // BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan,)));
  //   if (googleMapController.isCompleted) {
  //     mapController!.animateCamera(
  //         CameraUpdate.newCameraPosition(CameraPosition(target: lastMapPosition, zoom: allowZoomIn ? 14 : 11)));
  //   }
  //   setState(() {});
  // }
  final locationController = Get.put(LocationController());
  @override
  Widget build(BuildContext context) {
    log(appLanguage.toString());
    return WillPopScope(
      onWillPop: () async {
        mapController!.dispose();
        return true;
      },
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  zoomGesturesEnabled: true,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0),
                    zoom: 14.0, //initial zoom level
                  ),
                  mapType: MapType.normal,
                  onMapCreated: (controller) {
                    mapController = controller;
                    setState(() async {});
                  },
    markers: {
    if (redPinMarker != null) redPinMarker!,
    },
    onCameraMove: (CameraPosition cameraPositions) {
    if (isMarkerDraggable && redPinMarker != null) {
    setState(() {
    redPinMarker = redPinMarker!.copyWith(positionParam: cameraPositions.target);
    });
    }},
                  onCameraIdle: () async {},
                ),
                Positioned(
                    top: 10,
                    child: InkWell(
                        onTap: () async {
                          var place = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: googleApikey,
                              mode: Mode.overlay,
                              types: [],
                              strictbounds: false,
                              // components: [
                              //   Component(Component.country, appLanguage == "French" ? "fr" : appLanguage == "Spanish"?"es": appLanguage == "Arabic"?"ar":appLanguage == "English"?"en":"en")
                              // ],
                              onError: (err) {
                                log("error.....   ${err.errorMessage}");
                              });
                          if (place != null) {
                            setState(() {
                              _address = place.description.toString();
                            });
                            final plist = GoogleMapsPlaces(
                              apiKey: googleApikey,
                              apiHeaders: await const GoogleApiHeaders().getHeaders(),
                            );
                            print(plist);
                            String placeid = place.placeId ?? "0";
                            final detail = await plist.getDetailsByPlaceId(placeid);
                            final geometry = detail.result.geometry!;
                            final lat = geometry.location.lat;
                            final lang = geometry.location.lng;
                            var newlatlang = LatLng(lat, lang);
                            setState(() {
                              _address = place.description.toString();
                              _onAddMarkerButtonPressed(LatLng(lat, lang), place.description);
                            });
                            mapController?.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                            setState(() {});
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Card(
                            child: Container(
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width - 40,
                                child: ListTile(
                                  leading: const Icon(Icons.location_on_outlined, color: AppTheme.primaryColor),
                                  title: Text(
                                    _address.toString(),
                                    style: TextStyle(fontSize: AddSize.font14),
                                  ),
                                  trailing: const Icon(Icons.search),
                                  dense: true,
                                )),
                          ),
                        ))),
                Positioned(
                    bottom: 0,
                    child: Container(
                      height: AddSize.size200,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AddSize.padding16,
                          vertical: AddSize.padding10,
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: 200,
                          width: Get.width,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: AppTheme.primaryColor,
                                    size: AddSize.size25,
                                  ),
                                  SizedBox(
                                    width: AddSize.size12,
                                  ),
                                  Expanded(
                                    child: Text(
                                      _address.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(fontWeight: FontWeight.w500, fontSize: AddSize.font16),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Save Location',
                                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: AddSize.font16,
                                          color: const Color(0xff014E70)),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomOutlineButton(
                                title: "Confirm Your Location".tr,
                                borderRadius: 11,
                                onPressed: () {
                                  serviceController.countryController1.text = country.toString();
                                  serviceController.stateController1.text = state.toString();
                                  serviceController.cityController1.text = city.toString();
                                  serviceController.addressController.text = street.toString();
                                  serviceController.address2Controller.text = town.toString();
                                  serviceController.zipCodeController.text = zipcode.toString();
                                  bottomSheet(addressData: AddressData());
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
  Future bottomSheet({required AddressData addressData}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context12) {
          return const FindMyLocationEditAddressSheet();
        });
  }
}
