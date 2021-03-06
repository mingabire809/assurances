import 'dart:async';

import 'package:assurance/home.dart';
import 'package:assurance/partner.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  context, MaterialPageRoute(builder: (context) => Partner()));
            },
          );
        }),
        title: Text("Socar"),
      ),
      body: Container(
        child: ListView(
          children:<Widget> [
            Image.asset('images/coverbyinsurance.socar.jpg'),
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
                  MaterialPageRoute(builder: (context) => MapPageSocar()),
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
class MapPageSocar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageSocarState();
}
class MapPageSocarState extends State<MapPageSocar> {
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/coverbyinsurance.socar.jpg').then((onValue) {
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
            Image.asset('images/coverbyinsurance.socar.jpg'),
            SizedBox(height: 30.0),
            Text("La Soci??t?? Commerciale d???Assurances et de R??assurance Vie "
                "??SOCAR VIE s.a ?? en sigle est la premi??re soci??t?? d???assurance vie qui a ??t?? "
                "agr????e selon le nouveau code des Assurances en date du 26/12/2016 "
                "avec un capital social lib??r?? de BIF 603.000.000. "
                "SOCAR VIE S.A. est une Soci??t?? totalement priv??e,"
                " op??rationnelle depuis le 1er Janvier 2017.",
              style: TextStyle(fontSize: 15.0),),
            SizedBox(height: 10.0,),
            Text(
              "La Soci??t?? Commerciale d???Assurances et de R??assurance Vie ??SOCAR VIE s.a ?? en sigle"
                  " est la premi??re soci??t?? d???assurance vie qui a ??t?? agr????e selon le nouveau code des Assurances"
                  " en date du 26/12/2016 avec un capital social lib??r?? de BIF 502.500.000."
                  " SOCAR VIE S.A. est une Soci??t?? totalement priv??e, op??rationnelle depuis le 1er Janvier 2017."
                  " Voici l?????volution de notre chiffre d'affaire de 2017 ?? 2019 (en milliard de Fbu)",
              style: TextStyle(fontSize: 15.0),),
            SizedBox(height:10.0),
            Image.asset('images/evolution.png'),
            ListTile(
                leading: Icon(Icons.phone),
                title: Text("+257) 69 900 400"),
              onTap: ()=> launch("tel: +25769900400"),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("(+257) 75 103 000"),
              onTap: ()=> launch("tel: +25775103000"),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("(+257) 22 27 98 88"),
              onTap: ()=> launch("tel:+25722279888"),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("(+257) 76 999 950"),
              onTap: ()=> launch("tel:+25776999950"),
            ),
            ListTile(
                leading: Icon(Icons.mail),
                title: Text("info@socarvie.bi"),
              onTap: () => _launchURL('info@socarvie.bi', 'Flutter Email Test', 'Hello Flutter'),
            ),
            ListTile(
                leading: Icon(Icons.place),
                title: Text(" ROHERO I No 17, "
                    "Jonction Boulevard de l'ind??pendance "
                    "et l'avenue d'italie, Bujumbura-Burundi")
            ),
            SizedBox(height: 10.0,),
            Text("Nos Reassureurs"),
            Row(
              children:<Widget> [
                CircleAvatar(
                  backgroundImage: AssetImage("images/logoo1.png"),
                  radius: 50.0,
                ),
                SizedBox(width: 50.0,),
                CircleAvatar(
                  backgroundImage: AssetImage("images/logoo3.png"),
                  radius: 50.0,
                ),
                SizedBox(width: 20.0,),
                CircleAvatar(
                  backgroundImage: AssetImage("images/logoo4.png"),
                  radius: 50.0,
                )

              ],
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