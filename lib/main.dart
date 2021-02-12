import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iss_tracker/iss.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

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
  var lat, long, _snipp;

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/icon.png");
    return byteData.buffer.asUint8List();
  }

  Future<void> _getIss() async {
    Uint8List imageData = await getMarker();
    var url = "http://api.open-notify.org/iss-now.json";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var lati = jsonResponse['iss_position']['latitude'];
      var longi = jsonResponse['iss_position']['longitude'];
      lat = double.parse(lati);
      long = double.parse(longi);
      _snipp = lati + " " + longi;
      LatLng latlng = LatLng(lat, long);
      _controller.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(bearing: 0, target: latlng, tilt: 0, zoom: 5.00)));
      this.setState(() {
        marker = Marker(
          markerId: MarkerId("home"),
          icon: BitmapDescriptor.fromBytes(imageData),
          position: latlng,
          draggable: false,
          infoWindow: InfoWindow(
            title: 'International Space Center',
            snippet: _snipp,
            onTap: () {},
          ),
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
        zoomControlsEnabled: false,
        mapType: MapType.satellite,
        initialCameraPosition: CameraPosition(
          target: const LatLng(0, 0),
          zoom: 2,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: _getIss,
              label: Text('Find ISS'),
              backgroundColor: Colors.blue[900],
              icon: Icon(Icons.location_searching),
            ),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ISS()),
                );
              },
              backgroundColor: Colors.blue[900],
              icon: Icon(CupertinoIcons.info),
              label: Text('Info'),
            ),
          ],
        ),
      ),
    );
  }
}
