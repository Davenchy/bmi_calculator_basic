import 'package:flutter/material.dart';

import 'bmi_screen.dart';
import '../utils/bmi.dart';
import '../utils/bmi_memory.dart';
import '../widgets/custom_button.dart';
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

  late final BMIMemory memory;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey();

    heightController = TextEditingController();
    weightController = TextEditingController();
    heightFocusNode = FocusNode();
    weightFocusNode = FocusNode();

    memory = BMIMemory();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      heightFocusNode.requestFocus();
      memory.load();
    });
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    heightFocusNode.dispose();
    weightFocusNode.dispose();

    memory.dispose();
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: memory,
                    builder: (context, _) => bmi != null
                        ? BMIDescription(bmi!)
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: 'Height',
                    suffix: 'cm',
                    hint: '0',
                    controller: heightController,
                    focusNode: heightFocusNode,
                    nextFocusNode: weightFocusNode,
                    validator: (val) => propertyValidator('height', val),
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: 'Weight',
                    suffix: 'kg',
                    hint: '0',
                    controller: weightController,
                    focusNode: weightFocusNode,
                    validator: (val) => propertyValidator('weight', val),
                    onSubmitted: (_) => calculate(),
                  ),
                  const SizedBox(height: 32),
                  CustomButton(label: 'Calculate!', onPressed: calculate),
                  const SizedBox(height: 32),
                  AnimatedBuilder(
                    animation: memory,
                    builder: (context, child) =>
                        memory.hasData ? child! : const SizedBox.shrink(),
                    child: CustomButton(
                      label: 'Show Last BMI',
                      onPressed: loadLastBMI,
                    ),
                  ),
                ],
              ),
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

  void calculate() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final double height = double.tryParse(heightController.text) ?? 0;
    final double weight = double.tryParse(weightController.text) ?? 0;

    bmi = calculateBMI(weight, height / 100);
    memory.save(bmi!);
  }

  void loadLastBMI() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LastBMIScreen(memory: memory),
      ),
    );
  }
}
