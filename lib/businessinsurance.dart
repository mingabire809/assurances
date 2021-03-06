import 'dart:async';

import 'package:assurance/home.dart';
import 'package:assurance/partner.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about.dart';


class BusinessInsurance extends StatefulWidget {
  @override
  _BusinessInsuranceState createState() => _BusinessInsuranceState();
}

class _BusinessInsuranceState extends State<BusinessInsurance>{
  String _currentAddress;
  static const LatLng_center = const LatLng(-3.382860084919697, 29.367783099820198);
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
        title: Text("Business Insurance and Reinsurance"),
      ),
      body: Container(
        child: ListView(
          children:<Widget> [
            Image.asset('images/bic.jpg'),
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
                  MaterialPageRoute(builder: (context) => MapPageBic()),
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
class MapPageBic extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageBicState();
}
class MapPageBicState extends State<MapPageBic> {
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/bic.jpg').then((onValue) {
      pinLocationIcon = onValue;
    });

  }
  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(-3.382860084919697, 29.367783099820198);

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
            Image.asset('images/bic.jpg'),
            SizedBox(height: 30.0),
            Text("",
              style: TextStyle(fontSize: 15.0),),
            SizedBox(height: 10.0,),
            Text(
              "Business Insurance and Reinsurance Company SA (BIC) a ??t?? cr???? "
                  "par l???Association des Commer??ants du Burundi dans les domaines de l???Assurance Automobile,"
                  " Incendie, Accidents, Transport , Risques divers, Maladie, Pr??voyance et Epargne -Pension."
                "Notre soci??t?? a pour mission de transformer le secteur de l???assurance au Burundi"
                  " en offrant des prestations ax??es sur la qualit?? des services et "
                  "cela dans l???intention de mieux prot??ger les Clients contre les risques auxquels ils sont expos??s.",
              style: TextStyle(fontSize: 15.0),),
            SizedBox(height:10.0),
            Text("Business Insurance & Reinsurance Company S.A. (BIC) a la vision, la mission et les valeurs suivantes."

              "VISION"
             " Devenir un leader incontestable et incontournable du March?? d???assurances au Burundi"
                " qui soit Appr??ci??e et Tr??s Proche de ses Clients, avec un Service rapide et efficace."

              "MISSION"
              "Offrir des prestations ax??es sur la Qualit?? pour satisfaire les clients"
                " en maitrisant le d??veloppement du portefeuille dans la rentabilit??."
                "NOS VALEURS"
              "1. Ecoute et disponibilit??"
              "2. Int??grit?? et Equit??"
              "3. Travail d?????quipe"
              "4. Professionnalisme de haut niveau"
              "5. Respect des engagements et efficacit?? de nos actions"
              "6. Solidarit?? et confiance "),
            SizedBox(height: 10.0,),
            ListTile(
                leading: Icon(Icons.phone),
                title: Text("+257 2228 0042"),
              onTap: ()=> launch("tel:+25722280042"),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("+257 2228 0049"),
              onTap: ()=> launch("tel:+25722280049"),
            ),
            ListTile(
                leading: Icon(Icons.mail),
                title: Text("info@bic.bi"),
              //onTap: () => _launchURL('xxx@gmail.com', 'Flutter Email Test', 'Hello Flutter'), child: new Text('Send mail'),
              onTap: () {
                Navigator.push(
                  context,
                  _launchURL('info@bic.bic', 'Flutter Email Test', 'Hello Flutter'),
                );
              },
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