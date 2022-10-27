import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/ui/common_ui.dart';

class PickLocation extends StatefulWidget {
  final LatLng? displayLocation;

  const PickLocation({
    Key? key,
    this.displayLocation,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PickLocationState();
}

/// Place picker state
class PickLocationState extends State<PickLocation> {
  final Completer<GoogleMapController> mapController = Completer();

  /// Indicator for the selected location
  final Set<Marker> markers = {};

  /// Overlay to display autocomplete suggestions
  OverlayEntry? overlayEntry;

  GlobalKey appBarKey = GlobalKey();

  String _address = "";

  LatLng? selectedLatLng;

  // constructor
  PickLocationState();

  void onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    moveToCurrentUserLocation();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    markers.add(Marker(
      position: widget.displayLocation ?? const LatLng(5.6037, 0.1870),
      markerId: const MarkerId("selected-location"),
    ));
  }

  @override
  void dispose() {
    overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: appBarKey,
        title: const Text("Pick Location"),
        centerTitle: true,
        backgroundColor: Colours.blue.code,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.displayLocation ?? const LatLng(5.6037, 0.1870),
                zoom: 15,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: onMapCreated,
              onTap: (latLng) {
                clearOverlay();
                moveToLocation(latLng);
              },
              markers: markers,
            ),
          ),
          SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      _address,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Map<String, dynamic> locationResult = {"lat_lng": selectedLatLng, "address": _address};
                           Navigator.of(context).pop(locationResult);
                        },
                        child: appButton(bkColor: Colours.blue.code, text: AppConstants.submitText))
                  ],
                ),
              ))
        ],
      ),
    );
  }

  /// Hides the autocomplete overlay
  void clearOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  /// Moves the marker to the indicated lat,lng
  void setMarker(LatLng latLng) {
    // markers.clear();
    setState(() {
      markers.clear();
      markers.add(Marker(markerId: const MarkerId("selected-location"), position: latLng));
    });
  }

  /// This method gets the human readable name of the location. Mostly appears
  /// to be the road name and the locality.
  void reverseGeocodeLatLng(LatLng latLng) async {
    try {
      List<Placemark> newPlace = await GeocodingPlatform.instance.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

      // this is all you need
      Placemark placeMark = newPlace[0];
      String name = placeMark.name!;
      String subLocality = placeMark.subLocality!;
      String locality = placeMark.locality!;
      String administrativeArea = placeMark.administrativeArea!;
      String postalCode = placeMark.postalCode!;
      String country = placeMark.country!;
      String address = "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";

      /*if (kDebugMode) {
        print(address);
      }
*/
      setState(() {
        selectedLatLng = latLng;
        _address = address; // update _address
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  /// Moves the camera to the provided location and updates other UI features to
  /// match the location.
  void moveToLocation(LatLng latLng) {
    mapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 15.0)),
      );
    });
    setMarker(latLng);
    reverseGeocodeLatLng(latLng);
  }

  void moveToCurrentUserLocation() {
    if (widget.displayLocation != null) {
      moveToLocation(widget.displayLocation!);
      selectedLatLng = widget.displayLocation!;
    }
  }
}
