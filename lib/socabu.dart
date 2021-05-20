import 'package:assurance/partner.dart';
import 'package:url_launcher/url_launcher.dart';

import 'lib.dart';
import 'package:assurance/home.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'about.dart';


class Socabu extends StatefulWidget {
  @override
  _SocabuState createState() => _SocabuState();

}

class _SocabuState extends State<Socabu>{
  String _currentAddress;
  static const LatLng_center = const LatLng(-3.383394142509925, 29.36693282762696);
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
        title: Text("Socabu"),
      ),
      body: Container(
        child: ListView(
          children:<Widget> [
            Image.asset('images/coverbyinsurance.socabu.png'),
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
                  MaterialPageRoute(builder: (context) => MapPageSocabu()),
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
class MapPageSocabu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageSocabuState();
}
class MapPageSocabuState extends State<MapPageSocabu> {
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/coverbyinsurance.socabu.png').then((onValue) {
      pinLocationIcon = onValue;
    });

  }
  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(-3.383394142509925, 29.36693282762696);

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

class _AboutUsState extends State<AboutUs>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: ListView(
         children:<Widget> [
       Image.asset('images/coverbyinsurance.socabu.png'),
       SizedBox( height: 30.0),
           Text("To bring order to this sector and ensure protection of the heritage of individuals and businesses, the Government created SOCABU by Decree-Law No. 100/61 of June 29, 1977 and granted it a monopoly on the activity of insurance in Burundi."

               "SOCABU opened its doors on October 3, 1977 with a staff of 21 agents. The workforce now stands at 152."

               "The capital was 90% state and 10% Belgian private: Boels & Bégault and E.I.C."

               "In 1985, the State of Burundi ceded part of its shares to certain public and private enterprises, notably banks and financial institutions, and kept 50% of the SOCABU securities portfolio."

               "In 1989, the State of Burundi continued its policy of privatization. He favored companies to which he sold half of his shares."

               "SOCABU was assisted in its beginnings, in direct insurance and reinsurance, by the Belgian broker BOELS & BEGAULT."

               "All senior management, already equipped with some knowledge and techniques of insurance and reinsurance, were sent to Europe, to houses highly specialized in these fields, where they acquired in-depth and solid training."

               "From 1985, SOCABU was entirely directed and managed by nationals who took over from expatriates.",
             style: TextStyle(fontSize: 15.0),),
           SizedBox(height: 10.0),
           ListTile(
               leading: Icon(Icons.web),
               title: Text("https://coverbyinsurance.socabu-assurances.com/"),
               onTap: ()=> launch("https://coverbyinsurance.socabu-assurances.com/")
           ),




         ],
       ),
     ),
   );
  }


}




