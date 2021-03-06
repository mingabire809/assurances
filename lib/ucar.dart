import 'dart:async';

import 'package:assurance/home.dart';
import 'package:assurance/partner.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about.dart';


class Ucar extends StatefulWidget {
  @override
  _UcarState createState() => _UcarState();
}

class _UcarState extends State<Ucar>{
  String _currentAddress;
  static const LatLng_center = const LatLng(-3.3719271643125315, 29.364441142021384);
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
        title: Text("Ucar"),
      ),
      body: Container(
        child: ListView(
          children:<Widget> [
            Image.asset('images/coverbyinsurance.ucar.jpg'),
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
                  MaterialPageRoute(builder: (context) => MapPageUcar()),
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
class MapPageUcar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageUcarState();
}
class MapPageUcarState extends State<MapPageUcar> {
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/coverbyinsurance.ucar.jpg').then((onValue) {
      pinLocationIcon = onValue;
    });

  }
  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(-3.3719271643125315, 29.364441142021384);

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
            Image.asset('images/coverbyinsurance.ucar.jpg'),
            SizedBox(height: 30.0),
            Text("",
              style: TextStyle(fontSize: 15.0),),
            SizedBox(height: 10.0,),
            Text(
              "UCAR VIE ET CAPITALISATION S.A est une soci??t?? anonyme au capital social de 1.405.000.000 BIF "
                  "qui a ??t?? cr???? par l???Assembl??e G??n??rale des Actionnaires du 30/05/2017. "
                  "Elle a ??t?? cr????e en vue de r??pondre aux imp??ratifs "
                  "de la loi num??ro du 07/ 01/2014 portant codes des assurances au BURUNDI. "
                  " Ce code consacre la s??paration des deux branches d???assurance ?? savoir les assurances dommages "
                  "et les assurances des personnes. L???article 279 du m??me code stipule ?? son avant dernier paragraphe que "
                  "?? les soci??t??s d???assurances qui, ?? la date d???application du pr??sent code pratiquent ?? la fois "
                  "les op??rations relatives ?? l???assurance vie et ?? l???assurance non vie ?? ont un d??lai de trois ans pour s???y conformer.                                                                                                                                       Il est donc clair que l???UCAR VIE a ??t?? cr????e pour se conformer au code des assurances au Burundi",
              style: TextStyle(fontSize: 15.0),),
            SizedBox(height:10.0),
            ListTile(
                leading: Icon(Icons.phone),
                title: Text("+257 22 28 00 69"),
              onTap: ()=> launch("tel:+25722280069"),
            ),
            ListTile(
                leading: Icon(Icons.mail),
                title: Text("info@coverbyinsurance.ucar-vie.com"),
              onTap: () => _launchURL('info.insurance@egic.bi', 'Flutter Email Test', 'Hello Flutter'),
            ),
            ListTile(
                leading: Icon(Icons.place),
                title: Text("Chauss??e du peuple MURUNDI, immeuble UCAR II, Rez de chauss??e")
            ),



          ],
        ),
      ),
    );
  }
  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}