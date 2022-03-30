import 'package:flutter/material.dart';

class SOSButton extends StatelessWidget {
  const SOSButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        child: Container(
          height: 75.0,
          width: 130.0,
          child: FloatingActionButton.extended(
            heroTag: "SOS",
            label: const Text(
              "SOS",
              style: TextStyle(fontSize: 24.0),
            ),
            icon: const Icon(
              Icons.warning_rounded,
              size: 32.0,
            ),
            onPressed: () {
              print("Test");
            },
            backgroundColor: Colors.red,
          ),
        ),
        alignment: FractionalOffset(0.08, -0.66));
  }
}
