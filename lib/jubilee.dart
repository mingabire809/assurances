import 'dart:async';

import 'package:assurance/home.dart';
import 'package:assurance/partner.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about.dart';


class Jubilee extends StatefulWidget {
  @override
  _JubileeState createState() => _JubileeState();
}

class _JubileeState extends State<Jubilee>{
  String _currentAddress;
  static const LatLng_center = const LatLng(-3.382244874752131, 29.36285999980882);
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
        title: Text("Jubilee"),
      ),
      body: Container(
        child: ListView(
          children:<Widget> [
            Image.asset('images/coverbyinsurance.jubilee.jpg'),
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
                  MaterialPageRoute(builder: (context) => MapPageJubilee()),
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
class MapPageJubilee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageJubileeState();
}
class MapPageJubileeState extends State<MapPageJubilee> {
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/coverbyinsurance.jubilee.jpg').then((onValue) {
      pinLocationIcon = onValue;
    });

  }
  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(-3.382244874752131, 29.36285999980882);

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
            Image.asset('images/coverbyinsurance.jubilee.jpg'),
            SizedBox( height: 30.0),
            Text("From humble beginnings in 1937, "
                "Jubilee Insurance has spread its sphere of influence throughout"
                " the region to become the largest multi-line insurer in."
                "Today, Jubilee is the number one insurer in East Africa with over 250,000 clients, and over 320 employees."
                " Jubilee Insurance is also the largest provider of medical insurance across East Africa that includes many of the region’s blue chip companies."
                "Jubilee Insurance has a network of offices spanning Kenya, Uganda, Tanzania, Burundi and Mauritius."
                " And now your favorite insurer will soon be a Pan-African brand, issuing our customers with "
                "an assortment of innovative products expertly crafted to conveniently meet all your insurance needs."
                "Jubilee is the only ISO certified insurance group listed on the three East Africa stock exchanges"
                "• The Nairobi Stock Exchange (NSE),"
                 "• Dar es Salaam Stock Exchange and"
                 "• Uganda Securities Exchange."
                  "its regional offices are highly rated on leadership,"
                " quality and risk management and have been awarded an AA- in Kenya and Uganda, and an A+ in Tanzania.",
              style: TextStyle(fontSize: 15.0),),
            ListTile(
                leading: Icon(Icons.phone),
                title: Text("+257 22 27 58 20"),
              onTap: () =>launch("tel:+25722275820"),
            ),
            ListTile(
                leading: Icon(Icons.mail),
                title: Text("jicb@jubileeburundi.com"),
              onTap: () => _launchURL('jicb@jubileeburundi.com', 'Flutter Email Test', 'Hello Flutter'),
            ),
            ListTile(
                leading: Icon(Icons.web),
                title: Text("https://www.jubileeinsurance.com/bu/index.php"),
              onTap: () =>launch("https://www.jubileeinsurance.com/bu/index.php"),
            ),
            ListTile(
                leading: Icon(Icons.timelapse),
                title: Text("7:30 - 17:15")
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