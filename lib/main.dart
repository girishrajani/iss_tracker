import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(
    MaterialApp(
      home: IssTracker(),
    ),
  );
}

class IssTracker extends StatefulWidget {
  @override
  _IssTrackerState createState() => _IssTrackerState();
}

class _IssTrackerState extends State<IssTracker> {
  GoogleMapController _controller;
  Marker marker;
  var lat, long;

  Future<void> _getIss() async {
    var url = "http://api.open-notify.org/iss-now.json";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var lati = jsonResponse['iss_position']['latitude'];
      var longi = jsonResponse['iss_position']['longitude'];
      lat = double.parse(lati);
      long = double.parse(longi);
      LatLng latlng = LatLng(lat, long);
      _controller.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(bearing: 0, target: latlng, tilt: 0, zoom: 5.00)));
      this.setState(() {
        marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set.of((marker != null) ? [marker] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        mapType: MapType.satellite,
        initialCameraPosition: CameraPosition(
          target: const LatLng(0, 0),
          zoom: 2,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _getIss,
        backgroundColor: Colors.indigoAccent,
        label: Text(
          'Find ISS',
        ),
        icon: Icon(Icons.location_searching),
      ),
    );
  }
}
