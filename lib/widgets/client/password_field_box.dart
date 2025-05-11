import 'package:flutter/material.dart';
class PasswordFieldBox extends StatelessWidget {
  final void Function(String) onSubmitted;
  const PasswordFieldBox({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Introduce tu Contraseña',
    );

    final textController = TextEditingController();

    return Column(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: decoration,
              onChanged: (value) => {
                //movementProvider.movementList.length
                print('cambio detectado codigo $value'),
              },
              onFieldSubmitted: (value) {
                onSubmitted(textController.text);
              },
              controller: textController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed:
                  () => {
                    print('password es  ${textController.text.toString()}'),
                    onSubmitted(textController.text),
                  },
              child: Text('Abrir casillero', style: TextStyle(fontSize: 15)),
            ),
          ),
        ),
      ],
    );
  }
}
