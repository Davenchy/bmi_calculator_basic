import 'package:flutter/material.dart';

import '../utils/bmi.dart';

class BMIDescription extends StatelessWidget {
  const BMIDescription(this.bmi, {Key? key}) : super(key: key);

  final double bmi;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Your BMI is',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                bmi.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                'kg/m2',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          getBMIDescription(bmi),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: getBMIColor(bmi),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Normal BMI range: 18.5 - 25 kg/m2',
          style: TextStyle(fontSize: 18),
        ),
        const Divider(
          height: 40,
          thickness: 4,
        ),
      ],
    );
  }
}
