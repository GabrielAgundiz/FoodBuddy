import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodbuddy/service/location_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapSample extends StatefulWidget {
  final String lugar;
  final String name;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  const MapSample(this.lugar, this.name,
      {Key? key, required this.gestureRecognizers})
      : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final LocationService _locationService = LocationService();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Marker> _markers = {};

  CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _setInitialLocation();
  }

  Future<void> _setInitialLocation() async {
    String placeId = await _locationService.getLugarId(widget.lugar);
    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=APIKEY'));
    var json = convert.jsonDecode(response.body);
    var places = json['result'] as Map<String, dynamic>;

    final double lat = places['geometry']['location']['lat'];
    final double lng = places['geometry']['location']['lng'];
    final LatLng target = LatLng(lat, lng);

    setState(() {
      _initialPosition = CameraPosition(target: target, zoom: 15);
      _markers.add(
        Marker(
          markerId: MarkerId(widget.name),
          position: target,
          infoWindow: InfoWindow(title: widget.lugar),
        ),
      );
    });

    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_initialPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        gestureRecognizers: widget.gestureRecognizers,
        mapType: MapType.normal,
        markers: _markers,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
