class ModelData {
  final List<String> featureNames;
  final List<double> scalerMean;
  final List<double> scalerScale;
  final List<double> coefficients;
  final double intercept;
  final double threshold;

  ModelData({
    required this.featureNames,
    required this.scalerMean,
    required this.scalerScale,
    required this.coefficients,
    required this.intercept,
    required this.threshold,
  });

  factory ModelData.fromJson(Map<String, dynamic> json) {
    return ModelData(
      featureNames: List<String>.from(json['feature_names']),
      scalerMean: List<double>.from(
        json['scaler_mean'].map((x) => (x as num).toDouble()),
      ),
      scalerScale: List<double>.from(
        json['scaler_scale'].map((x) => (x as num).toDouble()),
      ),
      coefficients: List<double>.from(
        json['coefficients'].map((x) => (x as num).toDouble()),
      ),
      intercept: (json['intercept'] as num).toDouble(),
      threshold: (json['threshold'] as num).toDouble(),
    );
  }
}
