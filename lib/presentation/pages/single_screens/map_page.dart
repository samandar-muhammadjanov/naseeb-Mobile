// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names, deprecated_member_use, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naseeb/config/app_theme.dart';
import 'package:naseeb/domain/models/address_model.dart';
import 'package:naseeb/domain/repositories/location_service.dart';
import 'package:naseeb/presentation/pages/employer/detail/add_post_page.dart';
import 'package:naseeb/presentation/pages/employer/detail/profile_settings_page.dart';
import 'package:naseeb/presentation/pages/intro/registration_page.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  const MapPage(
      {super.key,
      this.firstName,
      this.lastName,
      this.isMale,
      this.birthDate,
      this.email,
      this.description,
      this.isForPost,
      this.isForUser,
      this.images,
      this.file});
  static const routeName = "/map";
  final String? firstName;
  final String? lastName;
  final bool? isMale;
  final String? birthDate;
  final String? email;
  final String? description;
  final bool? isForPost;
  final bool? isForUser;
  final List? images;
  final File? file;
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController googleMapController;
  // Position positon = await _determinePosition();
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(41.3047553, 69.2497373), zoom: 10);
  BitmapDescriptor? myIcon;
  Set<Marker> markers = {};
  TextEditingController searchController = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '122344';
  List<dynamic> _placesList = [];
  @override
  void initState() {
    super.initState();
    _determinePosition(context);
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(50, 50)),
      "assets/images/pins.png",
    ).then((onValue) {
      myIcon = onValue;
    });
    getUserLocation();
    searchController.addListener(() {
      onChange();
    });
  }

  onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggestion(searchController.text);
  }

  getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyDb6_C33guxksbYIFHFnsHU2o-QX7i0bxQ";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _placesList = body['predictions'];
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  String userLoc = '';
  late AddressModel address;
  void getUserLocation() async {
    Position position = await _determinePosition(context);

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        ),
      ),
    );
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        icon: myIcon!,
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
      ),
    );
    setState(() {});
  }

  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        ThemeModelInheritedNotifier.of(context).theme == AppTheme.darkTheme;

    Future<void> _setMapStyle() async {
      // Load the custom map style JSON from the assets folder
      String darkStyle = await DefaultAssetBundle.of(context)
          .loadString('assets/map_style_dark.json');
      String lightStyle = await DefaultAssetBundle.of(context)
          .loadString('assets/map_style_light.json');
      // Apply the custom style to the Google Map
      googleMapController.setMapStyle(isDarkMode ? darkStyle : lightStyle);
    }

    addMark(LatLng argument) async {
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(argument.latitude, argument.longitude),
            zoom: 15,
          ),
        ),
      );
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          icon: myIcon!,
          position: LatLng(
            argument.latitude,
            argument.longitude,
          ),
        ),
      );
      setState(() {});
      List<Placemark> placemarks =
          await placemarkFromCoordinates(argument.latitude, argument.longitude);
      setState(() {
        userLoc =
            "${placemarks.first.locality}, ${placemarks.first.subLocality}";
        address = AddressModel(
            placemarks.first.locality,
            placemarks.first.subLocality,
            argument.latitude.toString(),
            argument.longitude.toString());
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onTap: (argument) => addMark(argument),
            initialCameraPosition: initialCameraPosition,
            markers: markers,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
              _setMapStyle();
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        isVisible = true;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        isVisible = false;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      hintText: "Search Location",
                      hintStyle: const TextStyle(fontFamily: "sfPro"),
                      fillColor:
                          isDarkMode ? const Color(0xff2b2d3a) : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color(0xff2b2d3a)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _placesList
                            .map(
                              (e) => ListTile(
                                onTap: () async {
                                  setState(() {
                                    searchController.text = e["description"];
                                    isVisible = false;
                                  });
                                  var place = await LocationService().getPlace(
                                      searchController.text, _sessionToken);
                                  _goToPlace(place);
                                },
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  e['description'],
                                  style: const TextStyle(fontFamily: "sfPro"),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.isForPost ?? false) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPostPage(
                                address: address,
                                description: widget.description,
                                time: widget.birthDate,
                                amount: widget.firstName,
                                images: widget.images,
                                file: widget.file,
                              ),
                            ));
                      } else if (widget.isForUser ?? false) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProfileSettingsPage(address: address),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationPage(
                              address: address,
                              firstName: widget.firstName,
                              lastName: widget.lastName,
                              isMale: widget.isMale,
                              birthDate: widget.birthDate,
                              description: widget.description,
                              email: widget.email,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary:
                            userLoc.isNotEmpty ? kprimaryColor : kgreyColor,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 0,
                        shadowColor: Colors.white),
                    child: const Text(
                      "Select Address",
                      style: TextStyle(fontFamily: "sfPro"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                  onPressed: () {
                    LocationService()
                        .getPlace(searchController.text, _sessionToken);
                    // getUserLocation();
                  },
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: const Icon(
                    Icons.my_location_rounded,
                    color: white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    final region = place['formatted_address'].toString().split(', ');

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 15,
        ),
      ),
    );
    setState(() {
      address =
          AddressModel(region[0], region[1], lat.toString(), lng.toString());
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          icon: myIcon!,
          position: LatLng(
            lat,
            lng,
          ),
        ),
      );
    });
  }

  Future<Position> _determinePosition(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      userLoc = "${placemarks[0].locality}, ${placemarks[0].subLocality}";
      address = AddressModel(placemarks[0].locality, placemarks[0].subLocality,
          position.latitude.toString(), position.longitude.toString());
    });

    return position;
  }
}
