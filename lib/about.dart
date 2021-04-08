import 'package:assurance/home.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget{
  @override
  _AboutState createState() => _AboutState();
}
class _AboutState extends State<About>{
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
        title: Text("About Us"),
      ),
      body: Center(
        child: ListView(
          children:<Widget> [
            Image.asset('images/insurance.jpg'),
            SizedBox( height: 30.0),
            Text("Assurance is an application that was created with the purpose of linking"
                " insurances company with the customer, "
                "marketing their product and their type of covers."
                "From the customer end, they are able to choose the type of cover at the comfort of their house"
                "by simply providing all the information required and the rest will be taken care by the application",
            style: TextStyle(fontSize: 15.0),),
            SizedBox(height: 20.0,),

            Text("Your Satisfaction is our comfort",
            style: TextStyle(fontSize: 20.0),)

          ],
        ),
      ),
    );

  }

}