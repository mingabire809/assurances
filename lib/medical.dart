import 'package:assurance/category.dart';
import 'package:assurance/register.dart';
import 'package:assurance/registermedical.dart';
import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';





class Medical extends StatefulWidget{

  final auth = FirebaseAuth.instance;
  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    // here you write the codes to input the data into firestore
  }
  @override
  _MedicalState createState() => _MedicalState();
}
class _MedicalState extends State<Medical>{
  String _dropDownVal;
  String _dropCover;
  String _dropNumber;
  final auth = FirebaseAuth.instance;
  String today =  "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute)}";
  Widget _appBarTitle = new Text( 'Medical Cover');
  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    // here you write the codes to input the data into firestore
  }
  Future<String> getCurrentUID() async{
    //final FirebaseUser user = await auth.currentUser();
    //final String uid = user.uid;
    return  (await auth.currentUser()).uid;


  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    // Similarly we can get email as well
    //final uemail = user.email;
    print(uid);
    //print(uemail);
  }
  Future<String> inputDat() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    return uid;
  }

  final databaseReference = Firestore.instance;
  void createRecord() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    await databaseReference.collection("users")
        .document(instructor).collection("Cover").document("Cover Details")
        .updateData({
      'Cover':'$_appBarTitle' ,
      'Type of Cover':'$_dropDownVal' ,
      'Period of cover':'$_dropCover' ,
      'Number of person under cover':'$_dropNumber',
    }).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Register()));
    });
  }
  void createMedical() async{

    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    await databaseReference.collection("users")
        .document(instructor).collection("Cover").document("Medical")
        .setData({

       'Type of Cover':'$_dropCover' ,
      'Period of cover':'$_dropDownVal' ,
      'Number of person under cover':'$_dropNumber',
      'Provider': '',
      'Starting Date': '',
      'Agreement': '',

    }).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => RegisterMedical()));
    });

  }

  getDetails() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    return await Firestore.instance.collection('users').document(instructor).get();
  }
  void initState() {
    super.initState();
    getDetails().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  DocumentSnapshot querySnapshot;
  void medical() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    await databaseReference.collection("users")
        .document(instructor).collection('Cover').document('Medical')
        .setData({
      'Type of Cover':'$_dropCover' ,
      'Period of cover':'$_dropDownVal' ,
      'Number of person under cover':'$_dropNumber',
      'Provider': '',
      'Starting Date': '',
      'Agreement': '',

    }).then((_) async {
      await databaseReference.collection("Cover")
          .document(today)
          .setData({
        'Name':' ${querySnapshot.data['Full name']}',
        'Phone Number':' ${querySnapshot.data['Phone Number']}' ,
        'Email':'${querySnapshot.data['Email']}' ,
        'Cover':'$_appBarTitle' ,
        'Type of Cover':'$_dropCover' ,
        'Period of cover':'$_dropDownVal' ,
        'Number of person under cover':'$_dropNumber',
        'Provider': '',
        'Starting Date': '',
        'Agreement': '',

      },merge: true);
    }).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => RegisterMedical()));
    });
  }
  @override

  Widget build(BuildContext context) {
   /* Future<String> getCurrentUID() async{
      //final FirebaseUser user = await auth.currentUser();
      //final String uid = user.uid;
      return  (await auth.currentUser()).uid;


    }*/

    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Category()));
            },
          );
        }),
        title: _appBarTitle,
      ),
      body: Container(
        child: ListView(
            children: <Widget>[
        new DropdownButton<String>(
          hint: _dropCover == null
              ? Text('Type of cover')
              : Text(
            _dropCover,
            style: TextStyle(color: Colors.black),
          ),
          isExpanded: true,
          iconSize: 30.0,
          style: TextStyle(color: Colors.black),
          items: ['PPO', 'HMO','POS','EPOs','IHIP','HSA','HRAs'].map(
                (val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(val),
              );
            },
          ).toList(),
          onChanged: (val) {
            setState(
                  () {
                _dropCover = val;
              },
            );
          },
        ),
              new DropdownButton<String>(
                hint: _dropDownVal == null
                    ? Text('Period of Cover')
                    : Text(
                  _dropDownVal,
                  style: TextStyle(color: Colors.black),
                ),
                isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(color: Colors.black),
                items: ['3 Months', '6 Months','9 Months','1 Year','2 Years','3 Years'].map(
                      (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                        () {
                      _dropDownVal = val;
                    },
                  );
                },
              ),
              new DropdownButton<String>(
                hint: _dropNumber == null
                    ? Text('Number of Person under cover')
                    : Text(
                  _dropNumber,
                  style: TextStyle(color: Colors.black),
                ),
                isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(color: Colors.black),
                items: ['1', '2','3','4','5','6','7','8','9','10','More than 10','More than 50','More than 100'].map(
                      (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                        () {
                      _dropNumber = val;
                    },
                  );
                },
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text("Cancel"),
                    color: Colors.black38,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                    onPressed: null,
                  ),
                  RaisedButton(
                    child: Text("Proceed"),
                    color: Colors.lightBlueAccent,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    onPressed: () async{
                     // createRecord();
                     // createMedical();
                      medical();

                    },
                    /*onPressed: () async {
                    //  final uid = await Provider.of(context).auth.getCurrentUID();
                    //  String uid = FirebaseAuth.instance.currentUser.getuid();
                      String instructor = (await FirebaseAuth.instance.currentUser()).uid;
                    //  FirebaseAuth currentUser = FirebaseAuth.getInstance().getCurrentUser();
                      //if(currentUser != null)
                        //String uid = currentUser.getUid();
                      Firestore.instance
                          .collection("users")
                          .document(instructor).collection('cover')
                          .add({
                        "Cover":_appBarTitle ,
                        "Type of Cover":_dropDownVal ,
                        "Period of cover":_dropDownVal ,
                        "Number of person under cover":_dropNumber,

                      }).then((_) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Register()));
                      });
                    },*/
                    /*onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },*/
                  )
                ],
              ),

    ]

        )

    )
    );

  }

}
/*class Provider extends InheritedWidget {

  final db;

  Provider({Key key, Widget child, this.db}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<Provider>());
}*/