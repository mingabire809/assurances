import 'dart:async';

import 'package:assurance/home.dart';
import 'package:assurance/partner.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about.dart';


class Solis extends StatefulWidget {
  @override
  _SolisState createState() => _SolisState();
}

class _SolisState extends State<Solis>{
  String _currentAddress;
  static const LatLng_center = const LatLng(-3.3800104747291337, 29.368667770919764);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Partner()));
            },
          );
        }),
        title: Text("Solis"),
      ),
      body: Container(
        child: ListView(
          children:<Widget> [
            Image.asset('images/coverbyinsurance.solis.png'),
            SizedBox(height: 20.0,),
            /*ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/cover.jpg"),
              ),
              title: Text("Our Services"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Category()),
                );
              },
            ),*/
            if (_currentAddress != null) Text(
                _currentAddress
            ),
            FlatButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
                // Get location here
              },
            ),
            ListTile(
              leading: CircleAvatar(
                  child: Icon(Icons.place,color: Colors.white,),
                  backgroundColor: Colors.black54),
              title: Text("Location on Map"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPageSolis()),
                );
              },
            ),
            ListTile(
              leading: CircleAvatar(
                  child: Icon(Icons.question_answer_rounded,color: Colors.white,),
                  backgroundColor: Colors.black54),
              title: Text("About us"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUs()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  _getCurrentLocation() {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        // _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }
  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          LatLng_center.latitude,
          LatLng_center.longitude

      );

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.postalCode},${place.street},${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

}
class MapPageSolis extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageSolisState();
}
class MapPageSolisState extends State<MapPageSolis> {
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/coverbyinsurance.solis.png').then((onValue) {
      pinLocationIcon = onValue;
    });

  }
  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(-3.3800104747291337, 29.368667770919764);

    // these are the minimum required values to set
    // the camera position
    CameraPosition initialLocation = CameraPosition(
        zoom: 16,
        bearing: 30,
        target: pinPosition
    );
    return GoogleMap(
        myLocationEnabled: true,
        markers: _markers,
        initialCameraPosition: initialLocation,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setState(() {
            _markers.add(
                Marker(
                    markerId: MarkerId('1'),

                    position: pinPosition,
                    icon: pinLocationIcon
                )
            );
          });
        });
  }


}
class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();

}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Image.asset('images/coverbyinsurance.solis.png'),
            SizedBox(height: 30.0),
            Text("",
              style: TextStyle(fontSize: 15.0),),
            SizedBox(height: 10.0,),

            SizedBox(height:10.0),
            ListTile(
                leading: Icon(Icons.phone),
                title: Text("+257 22 27 68 13"),
                onTap: ()=> launch("tel:+25722276813"),
            ),
            ListTile(
                leading: Icon(Icons.web),
                title: Text("http://www.coverbyinsurance.solis.bi/"),
                onTap: ()=> launch("http://www.coverbyinsurance.solis.bi/")
            ),




          ],
        ),
      ),
    );
  }
}