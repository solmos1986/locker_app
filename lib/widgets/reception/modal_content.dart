import 'package:flutter/material.dart';

class ModalContent extends StatelessWidget {
  final void Function(bool state) onPressOk;
  final void Function(bool state)? onPressCancel;
  final String message;

  final String nameButonOk;
  final String nameButonCancel;

  const ModalContent({
    super.key,
    this.onPressCancel,
    required this.onPressOk,
    required this.message,
    required this.nameButonOk,
    required this.nameButonCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(child: Text(message, style: TextStyle(fontSize: 20))),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        onPressOk(true);
                      },
                      child: Text(nameButonOk, style: TextStyle(fontSize: 25)),
                    ),
                    TextButton(
                      onPressed: () {
                        onPressCancel!(false);
                        Navigator.pop(context);
                      },
                      child: Text(
                        nameButonCancel,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
