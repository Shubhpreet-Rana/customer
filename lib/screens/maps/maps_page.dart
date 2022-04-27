import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../common/colors.dart';
import '../../common/methods/common.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/drop_down.dart';
import '../../common/ui/headers.dart';
import '../../common/constants.dart';

class MyAppMap extends StatefulWidget {
  final bool showPickUp;
  final bool showMarker;

  const MyAppMap({Key? key, this.showPickUp = true, this.showMarker = false}) : super(key: key);

  @override
  State<MyAppMap> createState() => MyAppMapState();
}

class MyAppMapState extends State<MyAppMap> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  TextEditingController pickController = TextEditingController();
  TextEditingController dropController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.showMarker)_add();
  }

  void _add() {
    var markerIdVal = "Provider Location";
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        _kGooglePlex.target.latitude,
        _kGooglePlex.target.longitude,
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {},
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
                bottom: false,
                child: AppHeaders().collapsedHeader(
                    text: AppConstants.pickDL,
                    context: context,
                    backNavigation: true,
                    filterIcon: false,
                    onNotificationClick: () {
                      CommonMethods().openNotifications(context);
                    })),
            widget.showPickUp
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: searchBox(
                                controller: pickController,
                                isPrefix: true,
                                hintText: AppConstants.addressExp,
                                prefixIcon: const Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                ))),
                        horizontalSpacer(),
                        Expanded(
                            child: searchBox(
                                controller: dropController,
                                isPrefix: true,
                                hintText: "36 China town, D...",
                                prefixIcon: const Icon(
                                  Icons.location_pin,
                                  color: Colors.green,
                                ))),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            verticalSpacer(height: widget.showPickUp ? 0.0 : 20.0),
            Expanded(
              child: GoogleMap(
                mapType: MapType.terrain,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                markers: Set<Marker>.of(markers.values),
              ),
            ),
            verticalSpacer(height: 40.0)
          ],
        ),
      ),
    );
  }
}
