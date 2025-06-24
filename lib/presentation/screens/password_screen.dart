// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:locker_app/config/theme.dart';
import 'package:locker_app/infrastructure/models/verified_code_model.dart';
import 'package:locker_app/presentation/provider/verified_code_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

// ignore: use_key_in_widget_constructors
class Password extends StatelessWidget {
  //Password1({required super.builder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 0, 0, 0),
              const Color.fromARGB(255, 0, 0, 0),
            ],
            begin: Alignment.topRight,
          ),
        ),
        child: OtpScreen(),
      ),
    );
  }
}

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final verifiedCodeProvider = context.watch<VerifiedCodeProvider>();

    List<String> currentPin = ["", "", "", "", "", ""];

    TextEditingController pinOneController = TextEditingController();

    TextEditingController pinTwoController = TextEditingController();

    TextEditingController pinThreeController = TextEditingController();

    TextEditingController pinFourController = TextEditingController();

    TextEditingController pinFiveController = TextEditingController();

    TextEditingController pinSixController = TextEditingController();

    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.transparent),
    );

    int pinIndex = 0;

    void navigateConfirmate(VerifiedCodeModel verifiedCode) {
      Navigator.pushNamed(
        context,
        '/confirm-reception',
        arguments: verifiedCode,
      );
    }

    emitData() async {
      final uno = pinOneController.text.toString();
      final dos = pinTwoController.text.toString();
      final tres = pinThreeController.text.toString();
      final cuatro = pinFourController.text.toString();
      final cinco = pinFiveController.text.toString();
      final seis = pinSixController.text.toString();
      String value = "$uno$dos$tres$cuatro$cinco$seis";

      log("value ${value.toString()}");
      await verifiedCodeProvider.verifiedCode(value);
      if (verifiedCodeProvider.isValid) {
        //verifiedMovement();
        log("data ${verifiedCodeProvider.movement.numberDoor}");
        navigateConfirmate(verifiedCodeProvider.movement);
        /* await verifiedCodeProvider.updateMovement(
          verifiedCodeProvider.movement.movementId,
        ); */
      }
    }

    setPin(int n, String text) async {
      switch (n) {
        case 1:
          pinOneController.text = text;
          break;
        case 2:
          pinTwoController.text = text;
          break;
        case 3:
          pinThreeController.text = text;
          break;
        case 4:
          pinFourController.text = text;
          break;
        case 5:
          pinFiveController.text = text;
          break;
        case 6:
          pinSixController.text = text;
          log("ultimo valor ${n.toString()} text ${text.toString()} ");
          await emitData();
          break;
      }
    }

    clearPin() async {
      if (pinIndex == 0)
        pinIndex = 0;
      else if (pinIndex == 6) {
        await setPin(pinIndex, "");
        currentPin[pinIndex - 1] = "";
        pinIndex--;
      } else {
        await setPin(pinIndex, "");
        currentPin[pinIndex - 1] = "";
        pinIndex--;
      }
    }

    pinIndexSetup(String text) {
      if (pinIndex == 0)
        pinIndex = 1;
      else if (pinIndex < 6)
        pinIndex++;
      setPin(pinIndex, text);
      currentPin[pinIndex - 1] = text;
      String strPin = "";
      currentPin.forEach((e) {
        strPin += e;
      });
      if (pinIndex == 6) print(strPin);
    }

    /* grid(SizingInformation sizingInformation) {
      return GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[100],
            child: Text(" largo "),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[200],
            child: OrientationLayoutBuilder(
              portrait: (context) => Text('portrait '),
              landscape: (context) => Text('landscape '),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[300],
            child: const Text('Sound of screams but the'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[400],
            child: const Text('Who scream'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[500],
            child: const Text('Revolution is coming...'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[600],
            child: const Text('Revolution, they...'),
          ),
        ],
      );
    }
 */
    buildNumberPad() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: KeyboardNumber(
                  n: 1,
                  onPressed: () {
                    pinIndexSetup("1");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: KeyboardNumber(
                  n: 2,
                  onPressed: () {
                    pinIndexSetup("2");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: KeyboardNumber(
                  n: 3,
                  onPressed: () {
                    pinIndexSetup("3");
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: KeyboardNumber(
                  n: 4,
                  onPressed: () {
                    pinIndexSetup("4");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: KeyboardNumber(
                  n: 5,
                  onPressed: () {
                    pinIndexSetup("5");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: KeyboardNumber(
                  n: 6,
                  onPressed: () {
                    pinIndexSetup("6");
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: KeyboardNumber(
                  n: 7,
                  onPressed: () {
                    pinIndexSetup("7");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: KeyboardNumber(
                  n: 8,
                  onPressed: () {
                    pinIndexSetup("8");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: KeyboardNumber(
                  n: 9,
                  onPressed: () {
                    pinIndexSetup("9");
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 60.0,
                  child: MaterialButton(onPressed: null, child: SizedBox()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: KeyboardNumber(
                  n: 0,
                  onPressed: () {
                    pinIndexSetup("0");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 60.0,
                  child: MaterialButton(
                    onPressed: () async {
                      await clearPin();
                    },
                    child: Image.asset(
                      'assets/images/borrar.png',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    /* buildSecurityText() {
      return Text(
        "Ingrese su password",
        style: TextStyle(
          color: Colors.white70,
          fontSize: 21.0,
          fontWeight: FontWeight.bold,
        ),
      );
    } */

    buildPinRow() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              PINNumber(
                outlineInputBorder: outlineInputBorder,
                textEditingController: pinOneController,
              ),
              PINNumber(
                outlineInputBorder: outlineInputBorder,
                textEditingController: pinTwoController,
              ),
              PINNumber(
                outlineInputBorder: outlineInputBorder,
                textEditingController: pinThreeController,
              ),
              PINNumber(
                outlineInputBorder: outlineInputBorder,
                textEditingController: pinFourController,
              ),
              PINNumber(
                outlineInputBorder: outlineInputBorder,
                textEditingController: pinFiveController,
              ),
              PINNumber(
                outlineInputBorder: outlineInputBorder,
                textEditingController: pinSixController,
              ),
            ],
          ),
        ],
      );
    }

    /* buildExitButton() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () {
                //AQUI HACER QUE VUELVA A LA PANTALLA ANTERIOR
              },
              height: 50.0,
              minWidth: 50.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Icon(Icons.clear, color: Colors.white),
            ),
          ),
        ],
      );
    }
 */
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'Ingresa tu contraseña',
          style: TextStyle(color: ConfigColor.appBarTextColor),
        ),
      ),
      body: ResponsiveBuilder(
        builder:
            (context, sizingInformation) => Center(
              child: SingleChildScrollView(
                child:
                //buildExitButton(),
                Column(
                  children: [
                    buildPinRow(),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: buildNumberPad(),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );

    /* return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'QR no isValido',
          style: TextStyle(color: ConfigColor.appBarTextColor),
        ),
      ),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) => grid(sizingInformation),
      ),
    );*/
  }
}

class PINNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;
  // ignore: use_key_in_widget_constructors
  PINNumber({
    required this.textEditingController,
    required this.outlineInputBorder,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        obscureText: false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          border: outlineInputBorder,
          filled: true,
          fillColor: const Color.fromARGB(167, 247, 248, 248),
        ),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}

class KeyboardNumber extends StatelessWidget {
  final int n;
  final Function() onPressed;
  KeyboardNumber({required this.n, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color.fromARGB(251, 35, 121, 248).withOpacity(0.3),
      ),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: EdgeInsets.all(4.0),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        height: 80.0,
        child: Text(
          "$n",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24 * MediaQuery.of(context).textScaleFactor,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
