import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:calculator/theme/style.dart';
import 'package:calculator/components/neumorphism.dart';

Styles styles = new Styles();

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: <Widget>[
          Themes(),
          Credits(),
        ],
      ),
    );
  }
}

class Themes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      color: Theme.of(context).backgroundColor,
      width: size.width,
      height: size.height * 0.7,
      child: Padding(
        padding: EdgeInsets.only(top: 60, right: 30, left: 30),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.navigate_before,
                    color: Theme.of(context).primaryColor,
                    size: 40.0,
                  ),
                  Text(
                    'Settings',
                    style: styles.textStyle(
                      Theme.of(context).primaryColor,
                      20
                    ),
                  )
                ],
              ),
            ),
            ThemeSelector(),
          ],
        ),
      )
    );
  }
}

class ThemeSelector extends StatefulWidget {
  @override
  ThemeSelectorState createState() => ThemeSelectorState();
}

class ThemeSelectorState extends State<ThemeSelector> {
  var applied = false;
  var colorApplied = '';

  polishName(name) {
    var firstLetter = name.toString().split('')[0];
    var afterFirstLetter = name.toString().substring(1, name.length).toLowerCase();

    return '$firstLetter$afterFirstLetter';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Themes',
                style: styles.textStyle(
                  Theme.of(context).primaryColor,
                  24
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Highlights:',
                      style: styles.textStyle(
                          Theme.of(context).primaryColor,
                          16
                      ),
                    ),
                    applied ? Text(
                      '$colorApplied theme applied',
                      style: styles.textStyle(
                          Theme.of(context).accentColor,
                          14
                      ),
                    ) : Container()
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (var i in styles.themes) GestureDetector(
                    onTap: () => {
                      styles.setColorScheme(i['name']),
                      setState(() => {
                        applied = true,
                        colorApplied = polishName(i['name']),
                      })
                    },
                    child: NeumorphismTheme(
                        primary: (i['props'] as Map)['dark'],
                        secondary: (i['props'] as Map)['light'],
                        border: (i['props'] as Map)['border']
                    ),
                  )
                ],
              ),
            ],
          )
        )
      ],
    );
  }
}

class Credits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    getData() async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return packageInfo;
    }

    _launchGithub() async {
      const url = 'https://github.com/herbievine/calculator';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.connectionState == ConnectionState.done) {
          return Container(
            color: Theme.of(context).backgroundColor,
            width: size.width,
            height: size.height * 0.3,
            child: Padding(
              padding: EdgeInsets.all(40.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 1,
                    )
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Calculator',
                          style: styles.textStyle(
                              Theme.of(context).accentColor,
                              16
                          ),
                        ),
                      ),
                      Text(
                        snap.data.packageName,
                        style: styles.textStyle(
                          Theme.of(context).accentColor,
                          16
                        ),
                      ),
                      Text(
                        'v${snap.data.version}',
                        style: styles.textStyle(
                            Theme.of(context).accentColor,
                            16
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: () => _launchGithub(),
                          child: Text(
                            'GitHub',
                            style: styles.textStyle(
                              Theme.of(context).primaryColor,
                              16
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              )
            ),
          );
        } else {
          return Container();
        }
      }
    );
  }
}