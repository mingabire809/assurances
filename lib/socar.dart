import 'dart:async';

import 'package:assurance/home.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'about.dart';


class Socar extends StatefulWidget {
  @override
  _SocarState createState() => _SocarState();
}

class _SocarState extends State<Socar>{
  String _currentAddress;
  static const LatLng_center = const LatLng(-3.3849360094082823, 29.372018532338387);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          );
        }),
        title: Text("Socar"),
      ),
      body: Container(
        child: ListView(
          children:<Widget> [
            Image.asset('images/socar.jpg'),
            SizedBox(height: 20.0,),
           /* ListTile(
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
                  MaterialPageRoute(builder: (context) => MapPage()),
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
class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageState();
}
class MapPageState extends State<MapPage> {
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/socar.jpg').then((onValue) {
      pinLocationIcon = onValue;
    });

  }
  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(-3.3849360094082823, 29.372018532338387);

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
            Image.asset('images/socar.jpg'),
            SizedBox(height: 30.0),
            Text("La Société Commerciale d’Assurances et de Réassurance Vie "
                "«SOCAR VIE s.a » en sigle est la première société d’assurance vie qui a été "
                "agréée selon le nouveau code des Assurances en date du 26/12/2016 "
                "avec un capital social libéré de BIF 603.000.000. "
                "SOCAR VIE S.A. est une Société totalement privée,"
                " opérationnelle depuis le 1er Janvier 2017.",
              style: TextStyle(fontSize: 15.0),),
            SizedBox(height: 10.0,),
            Text(
              "La Société Commerciale d’Assurances et de Réassurance Vie «SOCAR VIE s.a » en sigle"
                  " est la première société d’assurance vie qui a été agréée selon le nouveau code des Assurances"
                  " en date du 26/12/2016 avec un capital social libéré de BIF 502.500.000."
                  " SOCAR VIE S.A. est une Société totalement privée, opérationnelle depuis le 1er Janvier 2017."
                  " Voici l’évolution de notre chiffre d'affaire de 2017 à 2019 (en milliard de Fbu)",
              style: TextStyle(fontSize: 15.0),),
            SizedBox(height:10.0),
            Image.asset('images/evolution.png'),
            ListTile(
                leading: Icon(Icons.phone),
                title: Text("+257) 69 900 400"
                  "(+257) 75 103 000"
                    "(+257) 22 27 98 88"
                "(+257) 76 999 950")
            ),
            ListTile(
                leading: Icon(Icons.mail),
                title: Text("info@socarvie.bi")
            ),
            ListTile(
                leading: Icon(Icons.place),
                title: Text(" ROHERO I No 17, "
                    "Jonction Boulevard de l'indépendance "
                    "et l'avenue d'italie, Bujumbura-Burundi")
            ),
            SizedBox(height: 10.0,),
            Text("Nos Reassureurs"),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/logoo1.png"),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/logoo3.png"),
              ),
            ),ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/logoo4.png"),
              ),
            ),


          ],
        ),
      ),
    );
  }
}