import 'dart:async';

import 'package:assurance/home.dart';
import 'package:assurance/partner.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about.dart';


class EastAfrica extends StatefulWidget {
  @override
  _EastAfricaState createState() => _EastAfricaState();
}

class _EastAfricaState extends State<EastAfrica>{
  String _currentAddress;
  static const LatLng_center = const LatLng(-3.3808193747469995, 29.357655370917243);
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
        title: Text("East Africa Global Insurance"),
      ),
      body: Container(
        child: ListView(
          children:<Widget> [
            Image.asset('images/egicnv.jpg'),
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
                  MaterialPageRoute(builder: (context) => MapPageEgiv()),
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
class MapPageEgiv extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageEgivState();
}
class MapPageEgivState extends State<MapPageEgiv> {
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/egicnv.jpg').then((onValue) {
      pinLocationIcon = onValue;
    });

  }
  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(-3.3808193747469995, 29.357655370917243);

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
            Image.asset('images/egicnv.jpg'),
            SizedBox(height: 30.0),
            Text("",
              style: TextStyle(fontSize: 15.0),),
            SizedBox(height: 10.0,),
            Text(
              "East Africa Global Insurance Company  Non Vie « EGIC-NV » en sigle,"
                  "est une compagnie d’assurances implantée au Burundi qui vient revolutionner le domaine des assurances."

                "Elle a obtenu son agrément définitif par la décision n° 540/93/001 du 20/12/2018"
                  " du Président de la Commision de Supervision et de Régulation des Assurances."

            "Elle est   enregistrée au Registre de Commerce sous le RC n° 06413."

                "C’est une Société Anonyme de droit burundais ayant pour objet,"
                  " la commercialisation des produits d’assurance au Burundi,"
                  "avec possibilité d’étendre ses activités dans la sous-région, et dans l’East African  Community en particulier."

            "La création de la Société EGIC-NV repose, dans la vision de ses promoteurs, sur un concept d’une entreprise d’assurances reposant sur un actionnariat large et diversifié.",
              style: TextStyle(fontSize: 15.0),),
            SizedBox(height:10.0),
            Text("EGIC est une compagnie qui peut donc compter sur ses forces intrinsèques suivantes :"
                "Un capital social de 2 004 000 000 FBU entièrement libéré avant le démarrage des activités."
                "Beaucoup d’actionnaires, personnes physiques ou morales, qui ont intérêt à soutenir leur Société."
                "Un actionnariat large et diversifié de nature à ne pas trop peser sur l’équipe de Direction."
                "Un actionnariat composé essentiellement de burundais, vivant à l’étranger, mais aussi réparti sur tout le pays,"
                " ce qui fait d’EGIC-NV une Société d’envergure nationale."
                "Un Portefeuille de base assurable important, fourni par les actionnaires eux-mêmes."
                "Des promoteurs du projet avisés et rodés, pouvant donner des orientations de la Politique Générale de la Compagnie."
                "Dans un premier temps, EGIC va commencer à commercialiser toutes les assurances non vie "
                "et principalement les assurances des Biens et de Responsabilité. "
                "Dans un proche avenir, elle étendra ses activités aux assurances vie et capitalisation. "),
            SizedBox(height: 10.0,),
            ListTile(
                leading: Icon(Icons.phone),
                title: Text("(+257) 22 28 40 40"),
                onTap: ()=> launch("tel:+25722284040"),
            ),
            ListTile(
                leading: Icon(Icons.phone),
                title: Text(" (+257) 22 28 40 42"),
              onTap: ()=> launch("tel:+25722284042"),
            ),
            ListTile(
                leading: Icon(Icons.mail),
                title: Text("info.insurance@egic.bi"),
                 onTap: () => _launchURL('info.insurance@egic.bi', 'Flutter Email Test', 'Hello Flutter'),
            ),
            ListTile(
                leading: Icon(Icons.place),
                title: Text(" Boulevard du 1er Novembre, Immeuble N°72 A"
                    "BP 6350, Bujumbura, BURUNDI")
            ),

            ListTile(
              leading: Icon(Icons.timelapse),
              title: Text("7:30 AM - 17:30 PM"),
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