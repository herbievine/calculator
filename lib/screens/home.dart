import 'package:flutter/material.dart';
import 'package:calculator/components/neumorphism.dart';
import 'package:calculator/theme/style.dart';
import 'package:rxdart/rxdart.dart';

Calculator calculatorService = new Calculator();
Styles styles = new Styles();

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: <Widget>[
          Setting(),
          Results(),
          Keypad()
        ],
      ),
    );
  }
}

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      color: Theme.of(context).backgroundColor,
      height: size.height * 0.15,
      width: size.width,
      child: Padding(
        padding: EdgeInsets.only(top: 40, left: 40, right: 40),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/settings'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.settings,
                color: Theme.of(context).primaryColor,
                size: 30.0,
              )
            ],
          ),
        ),
      )
    );
  }
}

class Results extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var _controller = ScrollController(initialScrollOffset: 0.0);
    calculatorService._history.listen((data) {
      if (_controller.hasClients) {
        _controller.animateTo(
          0.0,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut
        );
      }
    });

    return Container(
      color: Theme.of(context).backgroundColor,
      height: size.height * 0.3,
      width: size.width,
      child: Padding(
        padding: EdgeInsets.only(bottom: 40, right: 40, left: 40),
        child: ScrollConfiguration(
          behavior: new ScrollBehavior()..buildViewportChrome(context, SingleChildScrollView(), AxisDirection.down),
          child: SingleChildScrollView(
            controller: _controller,
            reverse: true,
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                History(),
                CurrentOperand(),
              ],
            ),
          )
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, StateSetter setState) => StreamBuilder(
          stream: calculatorService.historyStream$,
          builder: (BuildContext context, AsyncSnapshot snap) {
            if (snap.data != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  for (var i in snap.data) Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      i.toString(),
                      textAlign: TextAlign.right,
                      style: styles.textStyle(
                        Theme.of(context).accentColor,
                        20
                      ),
                    ),
                  )
                ],
              );
            }
            else {
              return Container();
            }
          },
        )
    );
  }
}

class CurrentOperand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, StateSetter setState) => Column(
        children: <Widget>[
          Container(
            alignment: Alignment(1, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                StreamBuilder(
                  stream: calculatorService.previousStream$,
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    return Text(
                      '${snap.data.toString()}',
                      textAlign: TextAlign.right,
                      style: styles.textStyle(
                        Color(0xff999999),
                        24
                      )
                    );
                  },
                ),
                StreamBuilder(
                  stream: calculatorService.currentStream$,
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    return Text(
                      '${snap.data == '' ? '0' : snap.data.toString()}',
                      textAlign: TextAlign.right,
                      style: styles.textStyle(
                        Theme.of(context).primaryColor,
                        30
                      )
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Keypad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
        color: Theme.of(context).backgroundColor,
        height: size.height * 0.55,
        width: size.width,
        child: Padding(
          padding: EdgeInsets.only(right: 40, left: 40, bottom: 40),
          child: FutureBuilder(
            future: styles.getColor(),
            builder: (BuildContext context, AsyncSnapshot<Map> snap) {
              if (snap.connectionState == ConnectionState.done) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => calculatorService.clear(),
                          child: NeumorphismButton(
                            darkColor: Color(0xff242424),
                            lightColor: Color(0xff333333),
                            borderColor: Color(0xff2B2B2B),
                            textColor: Theme.of(context).primaryColor,
                            text: 'C',
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => calculatorService.plusMinus(),
                          child: NeumorphismButton(
                            darkColor: Color(0xff242424),
                            lightColor: Color(0xff333333),
                            borderColor: Color(0xff2B2B2B),
                            textColor: Theme.of(context).primaryColor,
                            text: '±',
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => calculatorService.percent(),
                          child: NeumorphismButton(
                            darkColor: Color(0xff242424),
                            lightColor: Color(0xff333333),
                            borderColor: Color(0xff2B2B2B),
                            textColor: Theme.of(context).primaryColor,
                            text: '%',
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => calculatorService.chooseOperation('÷'),
                          child: NeumorphismButton(
                            darkColor: snap.data['dark'],
                            lightColor: snap.data['light'],
                            borderColor: snap.data['border'],
                            textColor: Theme.of(context).primaryColor,
                            text: '÷',
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => calculatorService.appendNumber(7),
                          child: NeumorphismButton(
                            darkColor: Color(0xff171717),
                            lightColor: Color(0xff2B2B2B),
                            borderColor: Color(0xff222222),
                            textColor: Theme.of(context).primaryColor,
                            text: '7',
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => calculatorService.appendNumber(8),
                          child: NeumorphismButton(
                            darkColor: Color(0xff171717),
                            lightColor: Color(0xff2B2B2B),
                            borderColor: Color(0xff222222),
                            textColor: Theme.of(context).primaryColor,
                            text: '8',
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => calculatorService.appendNumber(9),
                          child: NeumorphismButton(
                            darkColor: Color(0xff171717),
                            lightColor: Color(0xff2B2B2B),
                            borderColor: Color(0xff222222),
                            textColor: Theme.of(context).primaryColor,
                            text: '9',
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => calculatorService.chooseOperation('×'),
                          child: NeumorphismButton(
                            darkColor: snap.data['dark'],
                            lightColor: snap.data['light'],
                            borderColor: snap.data['border'],
                            textColor: Theme.of(context).primaryColor,
                            text: '×',
                          ),
                        )
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => calculatorService.appendNumber(4),
                          child: NeumorphismButton(
                            darkColor: Color(0xff171717),
                            lightColor: Color(0xff2B2B2B),
                            borderColor: Color(0xff222222),
                            textColor: Theme.of(context).primaryColor,
                            text: '4',
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => calculatorService.appendNumber(5),
                          child: NeumorphismButton(
                            darkColor: Color(0xff171717),
                            lightColor: Color(0xff2B2B2B),
                            borderColor: Color(0xff222222),
                            textColor: Theme.of(context).primaryColor,
                            text: '5',
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => calculatorService.appendNumber(6),
                          child: NeumorphismButton(
                            darkColor: Color(0xff171717),
                            lightColor: Color(0xff2B2B2B),
                            borderColor: Color(0xff222222),
                            textColor: Theme.of(context).primaryColor,
                            text: '6',
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => calculatorService.chooseOperation('-'),
                          child: NeumorphismButton(
                            darkColor: snap.data['dark'],
                            lightColor: snap.data['light'],
                            borderColor: snap.data['border'],
                            textColor: Theme.of(context).primaryColor,
                            text: '-',
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => calculatorService.appendNumber(1),
                          child: NeumorphismButton(
                            darkColor: Color(0xff171717),
                            lightColor: Color(0xff2B2B2B),
                            borderColor: Color(0xff222222),
                            textColor: Theme.of(context).primaryColor,
                            text: '1',
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => calculatorService.appendNumber(2),
                          child: NeumorphismButton(
                            darkColor: Color(0xff171717),
                            lightColor: Color(0xff2B2B2B),
                            borderColor: Color(0xff222222),
                            textColor: Theme.of(context).primaryColor,
                            text: '2',
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => calculatorService.appendNumber(3),
                          child: NeumorphismButton(
                            darkColor: Color(0xff171717),
                            lightColor: Color(0xff2B2B2B),
                            borderColor: Color(0xff222222),
                            textColor: Theme.of(context).primaryColor,
                            text: '3',
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => calculatorService.chooseOperation('+'),
                          child: NeumorphismButton(
                            darkColor: snap.data['dark'],
                            lightColor: snap.data['light'],
                            borderColor: snap.data['border'],
                            textColor: Theme.of(context).primaryColor,
                            text: '+',
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => calculatorService.appendNumber(0),
                          child: NeumorphismButton(
                            darkColor: Color(0xff171717),
                            lightColor: Color(0xff2B2B2B),
                            borderColor: Color(0xff222222),
                            textColor: Theme.of(context).primaryColor,
                            text: '0',
                            double: true,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => calculatorService.appendNumber('.'),
                          child: NeumorphismButton(
                            darkColor: Color(0xff171717),
                            lightColor: Color(0xff2B2B2B),
                            borderColor: Color(0xff222222),
                            textColor: Theme.of(context).primaryColor,
                            text: '.',
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => calculatorService.compute(true),
                          child: NeumorphismButton(
                            darkColor: snap.data['dark'],
                            lightColor: snap.data['light'],
                            borderColor: snap.data['border'],
                            textColor: Theme.of(context).primaryColor,
                            text: '=',
                          ),
                        )
                      ],
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          )
        )
    );
  }
}

class Calculator {
  BehaviorSubject _currentOperand = new BehaviorSubject.seeded('');
  BehaviorSubject _previousOperand = new BehaviorSubject.seeded('');
  BehaviorSubject _history = new BehaviorSubject<List<String>>();

  Stream get currentStream$ => _currentOperand.stream;
  String get current => _currentOperand.value;

  Stream get previousStream$ => _previousOperand.stream;
  String get previous => _previousOperand.value;

  Stream get historyStream$ => _history.stream;
  List<String> get history => _history.value;

  List<String> previousHistory = [];

  String operation;

  appendNumber(num) {
    if (current
        .toString()
        .length > 14) return;
    if (current.toString().contains('.') && num.toString() == '.') return;
    _currentOperand.add(current.toString() + num.toString());
  }

  compute(equals) {
    var computation;
    var opToUse = previous == '' ? operation : previous.toString().split(' ')[1];
    if (previous.length == 0 || current.length == 0) return;
    double $previous = double.parse(previous.toString().split(' ')[0]);
    double $current = double.parse(current);
    if ($current.isNaN || $previous.isNaN) return;
    switch (opToUse){
      case '+':
        computation = $previous + $current;
        break;
      case '-':
        computation = $previous - $current;
        break;
      case '×':
        computation = $previous * $current;
        break;
      case '÷':
        computation = $previous / $current;
        break;
      default:
        return;
    }
    if (equals == true) {
      operation = null;
      _currentOperand.add('');
      _previousOperand.add('');
      saveHistory(computation);
    } else {
      _currentOperand.add('');
      _previousOperand.add('${cleanDouble(computation)} $operation');
    }
  }

  plusMinus() {
    var inverse = double.parse(current) * -1;
    _currentOperand.add(cleanDouble(inverse));
  }

  percent() {
    var percent = double.parse(current) / 100;
    _currentOperand.add(cleanDouble(percent));
  }

  chooseOperation(op) {
    if (current == '') return;
    if (operation == null) operation = op;
    operation = op;
    if (previous != '') {
      compute(false);
    } else {
      _previousOperand.add('${cleanDouble(current)} $op');
    }
    _currentOperand.add('');
  }

  cleanDouble(num) {
    return num.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
  }

  saveHistory(num) {
    previousHistory.add(cleanDouble(num));
    _history.add(previousHistory);
  }

  clear() {
    _currentOperand.add('');
    _previousOperand.add('');
    operation = null;
  }
}