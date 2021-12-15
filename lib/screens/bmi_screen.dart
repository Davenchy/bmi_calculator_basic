import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/bmi_memory.dart';
import '../widgets/custom_button.dart';
import '../widgets/bmi_description.dart';

class LastBMIScreen extends StatelessWidget {
  const LastBMIScreen({
    Key? key,
    required this.memory,
  }) : super(key: key);

  final BMIMemory memory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Last BMI Results'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BMIDescription(memory.bmi),
              Text(
                'Calculated at ${Intl().date('EE, dd MMM yyyy').format(memory.date)}',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 32),
              CustomButton(
                label: 'Clear',
                onPressed: () => memory.clear().then(
                      (value) => Navigator.pop(context),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
