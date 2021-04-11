import 'package:assurance/ascoma.dart';
import 'package:assurance/bicor.dart';
import 'package:assurance/businessinsurance.dart';
import 'package:assurance/egiv.dart';
import 'package:assurance/mfp.dart';
import 'package:assurance/partner.dart';
import 'package:assurance/socabu.dart';
import 'package:assurance/socar.dart';
import 'package:assurance/solis.dart';
import 'package:assurance/ucar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'jubilee.dart';
import 'menu.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
              size: 20.0,
              semanticLabel: 'Menu',
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        title: Text(
          "Assurance",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              color: Colors.black,
              iconSize: 28.0,
              onPressed: null),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/path.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "Our Partner",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Partner()),
                          );
                        })
                ])),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Image.asset("images/it.jpg",
                            fit: BoxFit.cover, width: 190, height: 190),
                        Text(
                          "Insurances for IT Companies",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, _launchURL());
                  },
                ),
                InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Image.asset("images/whyassurance.jpg",
                            fit: BoxFit.cover, width: 190, height: 190),
                        Text(
                          "What Is Insurance",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, _Insurance());
                  },
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Image.asset("images/underwritting.jpg",
                            fit: BoxFit.cover, width: 190, height: 190),
                        Text(
                          "Underwritting Benefits",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, _Underwritting());
                  },
                ),
                InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Image.asset("images/work.jpg",
                            fit: BoxFit.cover, width: 190, height: 190),
                        Text(
                          "How insurance works",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, _Work());
                  },
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Image.asset("images/type.jpg",
                            fit: BoxFit.cover, width: 190, height: 190),
                        Text(
                          "4 Necessaries Insurance ",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, _TypeOfInsurance());
                  },
                ),
                InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Image.asset("images/retirement.jpg",
                            fit: BoxFit.cover, width: 190, height: 190),
                        Text(
                          "Insurance for Retirement",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, _Retirement());
                  },
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Image.asset("images/top.jpg",
                            fit: BoxFit.cover, width: 190, height: 190),
                        Text(
                          "Top 10 Insurers",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, _Top());
                  },
                ),
                InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Image.asset("images/digitalization.jpg",
                            fit: BoxFit.cover, width: 190, height: 190),
                        Text(
                          "Insurance Digitalization",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, _Digitalization());
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Others interesting topics on Insurance",
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context, _Topic());
                    })
            ])),
            SizedBox(height: 10.0)
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
      drawer: Menu(),
    );
  }
}

_launchURL() async {
  const url =
      "https://economictimes.indiatimes.com/small-biz/money/insurances-for-it-companies-why-you-need-it-and-how-to-go-about-it/articleshow/60709051.cms?from=mdr";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_Insurance() async {
  const url =
      "https://www.etmoney.com/blog/know-everything-about-insurance-and-why-you-should-have-insurance/";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_Underwritting() async {
  const url =
      "https://www.insurancetech.com/7-benefits-of-automated-underwriting/a/d-id/1315219d41d.html";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_Work() async {
  const url =
      "https://www.abi.org.uk/data-and-resources/tools-and-resources/how-insurance-works/";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_TypeOfInsurance() async {
  const url =
      "https://www.investopedia.com/financial-edge/0212/4-types-of-insurance-everyone-needs.aspx";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_Retirement() async {
  const url =
      "https://www.investopedia.com/articles/personal-finance/112614/strategies-use-life-insurance-retirement.asp";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_Top() async {
  const url =
      "https://www.insurancebusinessmag.com/asia/news/breaking-news/revealed--top-10-largest-insurance-companies-in-the-world-242743.aspx";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_Digitalization() async {
  const url = "https://www.softwaregroup.com/industry/insurance";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_Topic() async {
  const url =
      "https://www.google.com/search?q=interesting+topics+in+insurance&rlz=1C1CHBD_frBI884BI884&oq=best+topics+in+insur&aqs=chrome.1.69i57j0i22i30l2.10303j0j7&sourceid=chrome&ie=UTF-8";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
