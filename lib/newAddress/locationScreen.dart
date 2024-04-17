import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/common_button.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import '../widgets/dimension_screen.dart';
import 'customeraccountcreatedsuccessfullyScreen.dart';

class ChooseAddress extends StatefulWidget {
  ChooseAddress({
    super.key,
  });
  static var chooseAddressScreen = "/chooseAddressScreen";

  @override
  State<ChooseAddress> createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  final _formKey = GlobalKey<FormState>();
  final List<String> choiceAddress = ["Home", "Office", "Hotel", "Other"];
  final RxBool _isValue = false.obs;
  RxBool customTip = false.obs;
  RxString selectedChip = "Home".obs;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController otherController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController flatAddressController = TextEditingController();

  final Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? mapController;

  String? _address = "";
  Position? _currentPosition;

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

  Future<void> _getAddressFromLatLng(Position position) async {
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

  showChangeAddressSheet() {
    print(selectedChip.value);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Obx(() {
              return Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              setState(() {
                                _isValue.value = !_isValue.value;
                              });
                              Get.back();
                              setState(() {});
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: ShapeDecoration(color: Colors.transparent, shape: CircleBorder()),
                              child: Center(
                                  child: Icon(
                                Icons.clear,
                                color: Colors.transparent,
                                size: AddSize.size30,
                              )),
                            ),
                          ),
                          SizedBox(
                            height: AddSize.size20,
                          ),
                          Container(
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enter complete address".tr,
                                    style:
                                        TextStyle(color: Colors.transparent, fontWeight: FontWeight.w600, fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: AddSize.size12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      choiceAddress.length,
                                      (index) => chipList(choiceAddress[index].tr),
                                    ),
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  if (customTip.value)
                                    CommonTextField(
                                      hintText: "Other".tr,
                                    ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  CommonTextField(
                                    controller: streetAddressController,
                                    hintText: "Flat, House no, Floor, Tower,Street".tr,
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: 'Flat, House no, Floor, Tower,Street'),
                                    ]).call,
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  CommonTextField(
                                    controller: flatAddressController,
                                    hintText: "Street, Society, Landmark".tr,
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: 'Select city'),
                                    ]).call,
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  CommonTextField(
                                    hintText: "Recipient’s name".tr,
                                    controller: nameController,
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: 'Recipient’s name'),
                                    ]).call,
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  CustomOutlineButton(
                                    title: 'SAVE ADDRESS'.tr,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {}
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Obx(() {
                          //   return SizedBox(
                          //     height: sizeBoxHeight.value,
                          //   );
                          // })
                        ],
                      ),
                    ),
                  ));
            }),
          );
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

  String googleApikey = "AIzaSyAP9njE_z7lH2tii68WLoQGju0DF8KryXA";
  GoogleMapController? mapController1;
  CameraPosition? cameraPosition;
  String location = "Search Location";
  final Set<Marker> markers = {};
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<void> _onAddMarkerButtonPressed(LatLng lastMapPosition, markerTitle, {allowZoomIn = true}) async {
    final Uint8List markerIcon = await getBytesFromAsset('assets/icons/location.png', 140);
    markers.clear();
    markers.add(Marker(
        markerId: MarkerId(lastMapPosition.toString()),
        position: lastMapPosition,
        infoWindow: const InfoWindow(
          title: "",
        ),
        icon: BitmapDescriptor.fromBytes(markerIcon)));
    // BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan,)));
    if (googleMapController.isCompleted) {
      mapController!.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(target: lastMapPosition, zoom: allowZoomIn ? 14 : 11)));
    }
    setState(() {});
  }

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
            // appBar: backAppBar(
            //     title: _isValue.value == true ? "Complete Address".tr : "Choose Address".tr,
            //     context: context,
            //     dispose: "dispose",
            //     disposeController: () {
            //       mapController!.dispose();
            //     }),
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
              markers: markers,
              onCameraMove: (CameraPosition cameraPositions) {
                cameraPosition = cameraPositions;
              },
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
                              leading: Icon(Icons.location_on_outlined, color: AppTheme.primaryColor),
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
                      decoration: BoxDecoration(color: Colors.white),
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
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  'Save Location',
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.w600, fontSize: AddSize.font16, color: Color(0xff014E70)),
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
                              Get.to(const CustomerAccountCreatedSuccessfullyScreen());
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

  chipList(
    title,
  ) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Column(
        children: [
          ChoiceChip(
            padding: EdgeInsets.symmetric(horizontal: width * .01, vertical: height * .01),
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: title != selectedChip.value ? Colors.grey.shade300 : const Color(0xff7ED957))),
            label: Text("$title",
                style: TextStyle(
                    color: title != selectedChip.value ? Colors.grey.shade600 : const Color(0xff7ED957),
                    fontSize: AddSize.font14,
                    fontWeight: FontWeight.w500)),
            selected: title == selectedChip.value,
            selectedColor: const Color(0xff7ED957).withOpacity(.13),
            onSelected: (value) {
              selectedChip.value = title;
              if (title == "Other") {
                customTip.value = true;
                otherController.text = "";
              } else {
                customTip.value = false;
                otherController.text = title;
              }
              setState(() {});
            },
          )
        ],
      );
    });
  }
}
