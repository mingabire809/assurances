import 'package:assurance/login.dart';
import 'package:assurance/partner.dart';
import 'package:assurance/search.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'menu.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.uid}) : super(key: key);

  final String title;
  final String uid;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Assurance' );

 /* _ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }*/
  @override
 /* void initState() {
    this._getNames();
    super.initState();
  }*/
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
              tooltip: MaterialLocalizations
                  .of(context)
                  .openAppDrawerTooltip,
            );
          }),
          title: _appBarTitle,
          /*title: Text(
          "Assurance",
          style: TextStyle(color: Colors.black),
        ),*/
          actions: <Widget>[
            IconButton(
              icon: _searchIcon,
              color: Colors.black,
              iconSize: 28.0,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchList()));
              },),
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
                              MaterialPageRoute(
                                  builder: (context) => Partner()),
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
  /*Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['name'].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['name']),
          onTap: () => print(filteredNames[index]['name']),
        );
      },
    );
  }*/

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text( 'Assurance' );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  /*void _getNames() async {
    final response = await dio.get('https://swapi.co/api/people');
    List tempList = new List();
    for (int i = 0; i < response.data['results'].length; i++) {
      tempList.add(response.data['results'][i]);
    }
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }*/
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

/*class SearchBar extends StatefulWidget{
  @override
  _SearchBarState createState() => _SearchBarState();

}

class _SearchBarState extends State<SearchBar>{
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    leading: _isSearching ? const BackButton() : Container(),
    title: _isSearching ? _buildSearchField() : _buildTitle(context),
    actions: _buildActions(),
  ),

);

  }
  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}*/

