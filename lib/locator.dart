import 'dart:math';

import 'package:assurance/ascoma.dart';
import 'package:assurance/businessinsurance.dart';
import 'package:assurance/egiv.dart';
import 'package:assurance/mfp.dart';
import 'package:assurance/socabu.dart';
import 'package:assurance/socar.dart';
import 'package:assurance/solis.dart';
import 'package:assurance/ucar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'bicor.dart';
import 'jubilee.dart';


class Locator extends StatefulWidget {
  @override
  _LocatorState createState() => _LocatorState();
}

class _LocatorState extends State<Locator> {
  Position _currentPosition;
  String _currentAddress;
  String distanceAscoma;
  String distanceBicor;
  String distanceBic;
  String distanceegiv;
  String distanceJubilee;
  String distanceMfp;
  String distanceSocabu;
  String distanceSocar;
  String distanceSolis;
  String distanceUcar;
  String Nearest;
  double small;
  double distanceUcarInMeters;
  double distanceAscomaInMeters;
  double distanceBicorInMeters;
  double distanceBicInMeters;
  double distanceEgivInMeters;
  double distanceJubileeInMeters;
  double distanceMfpInMeters;
  double distanceSocabuInMeters;
  double distanceSocarInMeters;
  double distanceSolisInMeters;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*if (_currentPosition != null) Text(
                "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"
            ),*/
            if (_currentAddress != null) Text(
                _currentAddress
            ),

            SizedBox(height: 10.0,),
            if (distanceAscoma != null) Text('Ascoma Insurance Company is located at $distanceAscoma Meters from your current position'),
            SizedBox(height: 10.0,),
            if (distanceBicor != null) Text('Bicor Insurance Company is located at $distanceBicor Meters from your current position'),
            SizedBox(height: 10.0,),
            if (distanceBic != null) Text('Business Insurance Company Insurance is located at $distanceBic Meters from your current position'),
            SizedBox(height: 10.0,),
            if (distanceegiv != null) Text('East Africa Insurance Company is located at $distanceegiv Meters from your current position'),
            SizedBox(height: 10.0,),
            if (distanceJubilee != null) Text('Jubilee Insurance Company is located at $distanceJubilee Meters from your current position'),
            SizedBox(height: 10.0,),
            if (distanceMfp != null) Text('Mfp Insurance Company is located at $distanceMfp Meters from your current position'),
            SizedBox(height: 10.0,),
            if (distanceSocabu != null) Text('Socabu Insurance Company is located at $distanceSocabu Meters from your current position'),
            SizedBox(height: 10.0,),
            if (distanceSocar != null) Text('Socar Insurance Company is located at $distanceSocar Meters from your current position'),
            SizedBox(height: 10.0,),
            if (distanceSolis != null) Text('Solis Insurance Company is located at $distanceSolis Meters from your current position'),
            SizedBox(height: 10.0,),
            if (distanceUcar != null) Text('Ucar Insurance Company is located at $distanceUcar Meters from your current position'),
            SizedBox(height: 10.0,),
            if(Nearest != null) Text(Nearest),

            if(Nearest != null)RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "Get Direction",
                      style: TextStyle(color: Colors.black54, fontSize: 20.0, ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                            if(small == distanceAscomaInMeters){
                              Navigator.push(
                                context,

                                MaterialPageRoute(builder: (context) => MapPageAscoma()),
                              );
                            }
                            else if(small == distanceBicorInMeters){
                              Navigator.push(
                                context,

                                MaterialPageRoute(builder: (context) => MapPageBicor()),
                              );
                            }
                            else if(small == distanceBicInMeters){
                              Navigator.push(
                                context,

                                MaterialPageRoute(builder: (context) => MapPageBic()),
                              );
                            }
                            else if(small == distanceEgivInMeters){
                              Navigator.push(
                                context,

                                MaterialPageRoute(builder: (context) => MapPageEgiv()),
                              );
                            }
                            else if(small == distanceJubileeInMeters){
                              Navigator.push(
                                context,

                                MaterialPageRoute(builder: (context) => MapPageJubilee()),
                              );
                            }
                            else if(small == distanceMfpInMeters){
                              Navigator.push(
                                context,

                                MaterialPageRoute(builder: (context) => MapPageMfp()),
                              );
                            }
                            else if(small == distanceSocabuInMeters){
                              Navigator.push(
                                context,

                                MaterialPageRoute(builder: (context) => MapPageSocabu()),
                              );
                            }
                            else if(small == distanceSocarInMeters){
                              Navigator.push(
                                context,

                                MaterialPageRoute(builder: (context) => MapPageSocar()),
                              );
                            }
                            else if(small == distanceSolisInMeters){
                              Navigator.push(
                                context,

                                MaterialPageRoute(builder: (context) => MapPageSolis()),
                              );
                            }
                            else {
                              Navigator.push(
                                context,

                                MaterialPageRoute(builder: (context) => MapPageUcar()),
                              );
                            }
                        /*  Navigator.push(
                            context,

                            MaterialPageRoute(builder: (context) => MapPageAscoma()),
                          );*/
                        })

                ])),



            FlatButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
             //   _getNearestInsurance();
                // Get location here
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
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }
  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude,
          _currentPosition.longitude


      );

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.postalCode},${place.street},${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
         distanceUcarInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.3719271643125315, 29.364441142021384);
         distanceAscomaInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.393170054897287, 29.36094179975407);
         distanceBicorInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.3826858748346225, 29.369123213173157);
         distanceBicInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.382860084919697, 29.367783099820198);
         distanceEgivInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.3808193747469995, 29.357655370917243);
         distanceJubileeInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.382244874752131, 29.36285999980882);
         distanceMfpInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude ,-3.393170054897287, 29.36094179975407);
         distanceSocabuInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.383394142509925, 29.36693282762696);
         distanceSocarInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.3849360094082823, 29.372018532338387);
         distanceSolisInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.3800104747291337, 29.368667770919764);
        distanceAscoma = distanceAscomaInMeters.toString();
        distanceBicor = distanceBicorInMeters.toString();
        distanceBic = distanceBicInMeters.toString();
        distanceegiv = distanceEgivInMeters.toString();
        distanceJubilee = distanceJubileeInMeters.toString();
        distanceMfp = distanceMfpInMeters.toString();
        distanceSocabu = distanceSocabuInMeters.toString();
        distanceSocar = distanceSocarInMeters.toString();
        distanceSolis = distanceSolisInMeters.toString();
        distanceUcar = distanceUcarInMeters.toString();

         /* double*/ small = [distanceAscomaInMeters,distanceBicorInMeters,distanceBicInMeters,distanceEgivInMeters,distanceJubileeInMeters,distanceMfpInMeters,distanceSocabuInMeters,distanceSocarInMeters,distanceSolisInMeters,distanceUcarInMeters].reduce(min);
          if(small == distanceAscomaInMeters){
           /* RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: Nearest = 'Ascoma is the Nearest Insurance company near your current position and is located at $distanceAscomaInMeters',
                      style: TextStyle(color: Colors.black54, fontSize: 20.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {

                          Navigator.push(
                            context,

                            MaterialPageRoute(builder: (context) => MapPageAscoma()),
                          );
                        })
                ]));*/
            Nearest = 'Ascoma is the Nearest Insurance company near your current position and is located at $distanceAscomaInMeters';
          } else if (small == distanceBicorInMeters){
            /*RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text:Nearest = 'Bicor is the Nearest Insurance company near your current position and is located at $distanceBicorInMeters',
                      style: TextStyle(color: Colors.black54, fontSize: 20.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapPageBicor()),
                          );
                        })
                ]));*/
            Nearest = 'Bicor is the Nearest Insurance company near your current position and is located at $distanceBicorInMeters';

          }
          else if (small == distanceBicInMeters){
          /* RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text:Nearest = 'Business Insurance is the Nearest Insurance company near your current position and is located at $distanceBicInMeters',
                      style: TextStyle(color: Colors.black54, fontSize: 20.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapPageBic()),
                          );
                        })
                ]));*/
            Nearest = 'Business Insurance is the Nearest Insurance company near your current position and is located at $distanceBicInMeters';
          }

          else if (small == distanceEgivInMeters){
           /* RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: Nearest = 'East Africa Company is the Nearest Insurance company near your current position and is located at $distanceEgivInMeters',
                      style: TextStyle(color: Colors.black54, fontSize: 20.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapPageEgiv()),
                          );
                        })
                ]));*/
            Nearest = 'East Africa Company is the Nearest Insurance company near your current position and is located at $distanceEgivInMeters';
          }
          else if (small == distanceJubileeInMeters){
          /*  RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: Nearest = 'Jubilee is the Nearest Insurance company near your current position and is located at $distanceJubileeInMeters',
                      style: TextStyle(color: Colors.black54, fontSize: 20.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapPageJubilee()),
                          );
                        })
                ]));*/
            Nearest = 'Jubilee is the Nearest Insurance company near your current position and is located at $distanceJubileeInMeters';
          }
          else if (small == distanceMfpInMeters){
          /*  RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: Nearest = 'Mfp is the Nearest Insurance company near your current position and is located at $distanceMfpInMeters',
                      style: TextStyle(color: Colors.black54, fontSize: 20.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapPageMfp()),
                          );
                        })
                ]));*/
            Nearest = 'Mfp is the Nearest Insurance company near your current position and is located at $distanceMfpInMeters';
          }
          else if (small == distanceSocabuInMeters){
           /* RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text:  Nearest = 'Socabu is the Nearest Insurance company near your current position and is located at $distanceSocabuInMeters',
                      style: TextStyle(color: Colors.black54, fontSize: 20.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapPageSocabu()),
                          );
                        })
                ]));*/
            Nearest = 'Socabu is the Nearest Insurance company near your current position and is located at $distanceSocabuInMeters';
          }
          else if (small == distanceSocarInMeters){
          /*  RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text:  Nearest = 'Socar is the Nearest Insurance company near your current position and is located at $distanceSocarInMeters',
                      style: TextStyle(color: Colors.black54, fontSize: 20.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapPageSocar()),
                          );
                        })
                ]));*/
            Nearest = 'Socar is the Nearest Insurance company near your current position and is located at $distanceSocarInMeters';
          }
          else if (small == distanceSolisInMeters){
          /*  RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text:Nearest = 'Solis is the Nearest Insurance company near your current position and is located at $distanceSolisInMeters',
                      style: TextStyle(color: Colors.black54, fontSize: 20.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapPageSolis()),
                          );
                        })
                ]));*/
            Nearest = 'Solis is the Nearest Insurance company near your current position and is located at $distanceSolisInMeters';
          }
          else if (small == distanceUcarInMeters){
           /* RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text:Nearest = 'Ucar is the Nearest Insurance company near your current position and is located at $distanceUcarInMeters',
                      style: TextStyle(color: Colors.black54, fontSize: 20.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapPageUcar()),
                          );
                        })
                ]));*/
            Nearest = 'Ucar is the Nearest Insurance company near your current position and is located at $distanceUcarInMeters';
          }


      });
    } catch (e) {
      print(e);
    }

  }
  /*_getNearestInsurance(){
    double distanceUcarInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.3719271643125315, 29.364441142021384);
    double distanceAscomaInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.393170054897287, 29.36094179975407);
    double distanceBicorInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.3826858748346225, 29.369123213173157);
    double distanceBicInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.382860084919697, 29.367783099820198);
    double distanceEgivInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.3808193747469995, 29.357655370917243);
    double distanceJubileeInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.382244874752131, 29.36285999980882);
    double distanceMfpInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude ,-3.393170054897287, 29.36094179975407);
    double distanceSocabuInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.383394142509925, 29.36693282762696);
    double distanceSocarInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.3849360094082823, 29.372018532338387);
    double distanceSolisInMeters =  Geolocator.distanceBetween(_currentPosition.latitude,_currentPosition.longitude , -3.3800104747291337, 29.368667770919764);
    setState(() {
      Position positions;
      _currentPosition = positions;
      _getAddressFromLatLng();
      distanceAscoma = distanceAscomaInMeters.toString();
      distanceBicor = distanceBicorInMeters.toString();
      distanceBic = distanceBicInMeters.toString();
      distanceegiv = distanceEgivInMeters.toString();
      distanceJubilee = distanceJubileeInMeters.toString();
      distanceMfp = distanceMfpInMeters.toString();
      distanceSocabu = distanceSocabuInMeters.toString();
      distanceSocar = distanceSocarInMeters.toString();
      distanceSolis = distanceSolisInMeters.toString();
      distanceUcar = distanceUcarInMeters.toString();
    });
  }*/
}