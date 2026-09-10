import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import '../features/dyslexia_assessment/data/models/model_data.dart';

class DyslexiaService {
  ModelData? _modelData;

  Future<void> initModel() async {
    final jsonString = await rootBundle.loadString(
      'assets/dyslexia_flutter_model.json',
    );
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _modelData = ModelData.fromJson(jsonMap);
  }

  bool predict(List<double> rawInputs) {
    if (_modelData == null) {
      throw Exception("النموذج غير محمل، يرجى استدعاء initModel أولاً");
    }

    final model = _modelData!;
    if (rawInputs.length != model.featureNames.length) {
      throw Exception("عدد المدخلات غير مطابق لعدد الخصائص المطلوب");
    }

    // 1. Standardization
    List<double> scaledInputs = [];
    for (int i = 0; i < rawInputs.length; i++) {
      double scaled =
          (rawInputs[i] - model.scalerMean[i]) / model.scalerScale[i];
      scaledInputs.add(scaled);
    }

    // 2. Linear Combination (z = w*x + b)
    double z = model.intercept;
    for (int i = 0; i < scaledInputs.length; i++) {
      z += scaledInputs[i] * model.coefficients[i];
    }

    // 3. Sigmoid Function
    double probability = 1 / (1 + exp(-z));

    // 4. Threshold Decision
    return probability >= model.threshold;
  }
}
