import 'dart:io';
import 'package:assurance/coverbyinsurance/cover.dart';
import 'package:assurance/currentcover.dart';
import 'package:assurance/event.dart';
import 'package:assurance/notification.dart';
import 'package:assurance/retrievecover.dart';
import 'package:assurance/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:assurance/about.dart';
import 'package:assurance/camera.dart';
import 'package:assurance/category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:assurance/locator.dart';
import 'package:assurance/login.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'map.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/scroll_view.dart';


class Menu extends StatefulWidget {

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final auth = FirebaseAuth.instance;
  File _image;
  final picker = ImagePicker();
  FirebaseUser currentUser;
  String imageUrl;
  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    // here you write the codes to input the data into firestore
  }
  FirebaseStorage storage = FirebaseStorage.instance;
  StorageReference storageReference = FirebaseStorage.instance.ref();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
    );
  }
  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    getDetails().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }


  void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() { // call setState to rebuild the view
        this.currentUser = user;
      });
    });
  }

  String _email() {
    if (currentUser != null) {
      return currentUser.email;
    } else {
      return "no current user";
    }
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }


  void _showPicker(context)  {

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        _imgFromGallery();

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );

        });

  }
  final databaseReference = Firestore.instance;
  Future<void> getData() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    databaseReference
        .collection(instructor)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => '${f.data}}');
    });
  }

  getDetails() async {
    String instructor = (await FirebaseAuth.instance.currentUser()).uid;
    return await Firestore.instance.collection('users').document(instructor).get();
  }
 /* void initStat() {
    super.initState();
    getDetails().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }*/

  DocumentSnapshot querySnapshot;
String name() {
  if ({querySnapshot.data['Full name']} != null){
   return querySnapshot.data['Full name'].toString();
  }
  else
    return 'No current User';
}


  @override
  Widget build(BuildContext context) {


      var drawerHeader = UserAccountsDrawerHeader(
      accountName: /*Text(' ${querySnapshot.data['Full name']}')*/ Text(name()),
      accountEmail: Text(_email()),
      decoration: BoxDecoration(color: Colors.black38),
      currentAccountPicture: CircleAvatar(
        radius: 55,
        backgroundColor: Color(0xffFDCF09),
       child:  Image.network('${querySnapshot.data['Image Url']}', width: 100,
         height: 100,
         fit: BoxFit.cover,),
       /* child: imageUrl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
              //   imageUrl,
                  '${querySnapshot.data['Image Url']}',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50)),
                width: 100,
                height: 100,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[800],
                ),
              ),*/
      ),
    );

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          leading: CircleAvatar(
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
              backgroundColor: Colors.black54),
          title: Text("Home"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Retrieve()),
            );
          },
/*onTap: () async {
  String instructor = (await FirebaseAuth.instance.currentUser()).uid;
 DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(instructor).get();
  var channelName = snapshot['channelName'];
  if (channelName is String) {
    return channelName;
  } 


},*/
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("images/cover.jpg"),
          ),
          title: Text("Cover"),
          onTap: ()=> showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Select Your type'),
                actions: [
                  FlatButton(
                    onPressed: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Category()),
                );
              },
                    child: Text('By Cover'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Cover()),
                      );
                    },
                    child: Text('By company'),
                  ),
                ],
              );
            })
         /* onTap: () async {
            String instructor = (await FirebaseAuth.instance.currentUser()).uid;
            await databaseReference.collection("users")
                .document(instructor).collection("Cover").document("Cover Details")
                .setData({
            'Agreement': '',
            'Cover': '' ,
            'Period of cover':'' ,
            'Provider': '',
            'Starting Date': '',
            'Amount Assured': '',

            }).then((_) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Category()));
            });
          },*/
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("images/cover.jpg"),
          ),
          title: Text("Current Cover"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CurrentCover()),
            );
          },
        ),
        ListTile(
          leading: CircleAvatar(
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
            backgroundColor: Colors.black54,
          ),
          title: Text("Profile"),
          onTap: () {
           // _showPicker(context);
            uploadImage();
            //uploadImageToFirebase(context);
          },
        ),
        ListTile(
          leading: CircleAvatar(
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
            backgroundColor: Colors.black54,
          ),
          title: Text("User Details"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoadDataFromFirestore()),
            );
          },
        ),
        ListTile(
          leading: CircleAvatar(
            child: Icon(
              Icons.update,
              color: Colors.white,
            ),
            backgroundColor: Colors.black54,
          ),
          title: Text("Update"),
          onTap:(){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Events()),
            );
          } ,
        ),
        ListTile(
          leading: CircleAvatar(
            child: Icon(
              Icons.notification_important,
              color: Colors.white,
            ),
            backgroundColor: Colors.black54,
          ),
          title: Text("Notifications"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Notifications()),
            );
          },
        ),
        ListTile(
          leading: CircleAvatar(
            child: Icon(
              Icons.update,
              color: Colors.white,
            ),
            backgroundColor: Colors.black54,
          ),
          title: Text("Camerawesome"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Camerawesome()),
            );
          },
        ),
        ListTile(
          leading: CircleAvatar(
              child: Icon(
                Icons.question_answer_rounded,
                color: Colors.white,
              ),
              backgroundColor: Colors.black54),
          title: Text("About us"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => About()),
            );
          },
        ),
        ListTile(
          leading: CircleAvatar(
              child: Icon(
                Icons.map,
                color: Colors.white,
              ),
              backgroundColor: Colors.black54),
          title: Text("Map"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Map()),
            );
          },
        ),
        ListTile(
          leading: CircleAvatar(
              child: Icon(
                Icons.map,
                color: Colors.white,
              ),
              backgroundColor: Colors.black54),
          title: Text("My position"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Locator()),
            );
          },
        ),
        ListTile(
            leading: CircleAvatar(
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                backgroundColor: Colors.black54),
            title: Text("Logout"),
            onTap: () => showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text('Do you want to logout?'),
                    actions: [
                      FlatButton(
                        onPressed: () =>
                            Navigator.pop(context, false), // passing false
                        child: Text('No'),
                      ),
                      FlatButton(
                        onPressed: () {
                          auth.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Login()));
                        },
                        /*onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },*/ //

                        child: Text('Yes'),
                      ),
                    ],
                  );
                })),
        ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
              backgroundColor: Colors.black54,
            ),
            title: Text("Exit"),
            onTap: () => showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text('Do you want to exit?'),
                    actions: [
                      FlatButton(
                        onPressed: () => Navigator.pop(context, false),
                        // passing false
                        child: Text('No'),
                      ),
                      FlatButton(
                        onPressed: () => exit(0), // passing true
                        child: Text('Yes'),
                      ),
                    ],
                  );
                })),
      ],
    );
    return Scaffold(
      body: Container(
        child: drawerItems,
        color: Colors.white,
      ),
    );
  }
  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;


    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null){
        //Upload to Firebase
        var snapshot = await _storage.ref()
            .child('folderName/imageName')
            .putFile(file)
            .onComplete;

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }

    } else {
      print('Grant Permissions and try again');
    }




  }
}





