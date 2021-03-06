import 'dart:async';

import 'package:assurance/home.dart';
import 'package:assurance/partner.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about.dart';


class Mfp extends StatefulWidget {
  @override
  _MfpState createState() => _MfpState();
}

class _MfpState extends State<Mfp>{
  String _currentAddress;
  static const LatLng_center = const LatLng(-3.393170054897287, 29.36094179975407);
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
        title: Text("Mutuelle de la Fonction Publique"),
      ),
      body: Container(
        child: ListView(
          children:<Widget> [
            Image.asset('images/coverbyinsurance.mfp.jpg'),
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
                  MaterialPageRoute(builder: (context) => MapPageMfp()),
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
class MapPageMfp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageMfpState();
}
class MapPageMfpState extends State<MapPageMfp> {
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/coverbyinsurance.mfp.jpg').then((onValue) {
      pinLocationIcon = onValue;
    });

  }
  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(-3.393170054897287, 29.36094179975407);

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
            Image.asset('images/coverbyinsurance.mfp.jpg'),
            SizedBox(height: 30.0),
            Text("",
              style: TextStyle(fontSize: 15.0),),
            SizedBox(height: 10.0,),
            Text(
              "La Mutuelle de la Fonction Publique g??re le r??gime d???assurance maladie maternit??"
                  " institu?? en faveur des agents publics et assimil??s au Burundi.",
              style: TextStyle(fontSize: 15.0),),
            SizedBox(height:10.0),
            Text("La Mutuelle dela Fonction Publique a ??t?? cr????e par d??cret n??100/107 du 27 Juin 1980 "
                "pour g??rer le r??gime d???assurance maladie maternit?? institu?? en faveur "
                "des agents publics et assimil??s."
                " Son r??le est d???organiser un syst??me de soins m??dicaux modernes "
                "et fiable fond?? sur la participation des b??n??ficiaires."
              "Les prestations couvertes par la MFP sont:"
              "- Les consultations m??dicales"
              "- Les examens de laboratoire"
              "- Les actes chirurgicaux"
              "- L???hospitalisation"
              "- Les m??dicaments"
              "A cet effet, des guichets d???accueil sont ouverts dans les h??pitaux partenaires ci-apr??s :"
              "- Clinique Prince Louis RWAGASORE"
              "- H??pital Prince R??gent Charles"
              "- Centre Hospitalo-Universitaire de Kamenge"
              "- H??pital Militaire de Kamenge"
              "- Centre Neuropsychiatrique de Kamenge"
              "- H??pital de Cibitoke"
              "- H??pital de Kayanza"
              "- H??pital de Ngozi"
              "- H??pital de Cankuzo"
              "- H??pital de Ruyigi"
              "- H??pital de Rutana"
              "- H??pital de Gitega"
              "- H??pital de Muramvya"
              "- H??pital de Bururi"
              "- H??pital de Makamba"
              "- H??pital de Rumonge"
              "La MFP collabore en outre avec les Centres de Sant?? publics."
              "La MFP s'est aussi engag?? ?? disponibiliser le m??dicament pour ses assur??s "
              "et pour toute la population."
              "C'est ainsi que 30 officines pharmaceutiques sont ouvertes ?? travers tout le pays depuis 1989."),
            SizedBox(height: 10.0,),
            ListTile(
                leading: Icon(Icons.phone),
                title: Text("+257 22 22 30 67"),
                onTap: () =>launch("tel:+25722223067"),
            ),
            ListTile(
                leading: Icon(Icons.mail),
                title: Text("pharma.coverbyinsurance.mfp@gmail.com"),
              onTap: () {
                Navigator.push(
                  context,
                  _launchURL('pharma.coverbyinsurance.mfp@gmail.com', 'Flutter Email Test', 'Hello Flutter'),
                );
              },
            ),
            ListTile(
                leading: Icon(Icons.web),
                title: Text("http://coverbyinsurance.mfp-burundi.org/"),
                onTap: () =>launch("http://coverbyinsurance.mfp-burundi.org/"),
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