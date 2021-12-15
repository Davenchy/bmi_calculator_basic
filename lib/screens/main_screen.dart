import 'package:flutter/material.dart';

import '../utils/bmi.dart';
import '../widgets/bmi_description.dart';
import '../widgets/custom_text_field.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double? bmi;

  late final GlobalKey<FormState> formKey;

  late final TextEditingController heightController;
  late final TextEditingController weightController;

  late final FocusNode heightFocusNode;
  late final FocusNode weightFocusNode;

  @override
  void initState() {
    formKey = GlobalKey();

    heightController = TextEditingController(text: '0');
    weightController = TextEditingController(text: '0');
    heightFocusNode = FocusNode();
    weightFocusNode = FocusNode();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      heightFocusNode.requestFocus();
    });

    super.initState();
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    heightFocusNode.dispose();
    weightFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                if (bmi != null) BMIDescription(bmi!),
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'Height',
                  suffix: 'cm',
                  controller: heightController,
                  focusNode: heightFocusNode,
                  nextFocusNode: weightFocusNode,
                  validator: (val) => propertyValidator('height', val),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'Weight',
                  suffix: 'kg',
                  controller: weightController,
                  focusNode: weightFocusNode,
                  validator: (val) => propertyValidator('weight', val),
                  onSubmitted: (_) => _calculate(),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? propertyValidator(String property, String? height) {
    if (height == null || height.isEmpty) return '$property is required';

    final double? heightValue = double.tryParse(height);
    if (heightValue == null) return '$property must be a number';

    if (heightValue == 0) return '$property can not be zero';
    if (heightValue < 0) return '$property must be positive';
  }

  void _calculate() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final double height = double.tryParse(heightController.text) ?? 0;
    final double weight = double.tryParse(weightController.text) ?? 0;

    final double bmi = calculateBMI(weight, height / 100);

    setState(() => this.bmi = bmi);
  }
}
