import 'package:flutter/material.dart';

class ModalContent extends StatelessWidget {
  final void Function(bool state) onPressOk;
  final void Function(bool state) onPressCancel;
  final String message;

  const ModalContent({
    super.key,
    required this.onPressCancel,
    required this.onPressOk,
    required this.message,
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
                      child: const Text('Si', style: TextStyle(fontSize: 25)),
                    ),
                    TextButton(
                      onPressed: () {
                        onPressCancel(false);
                        Navigator.pop(context);
                      },
                      child: const Text('No', style: TextStyle(fontSize: 25)),
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
