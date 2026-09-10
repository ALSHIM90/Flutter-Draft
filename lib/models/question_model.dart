class QuestionModel {
  final String text;
  final Map<String, double> options; // النص مقابل القيمة الرقمية

  QuestionModel({required this.text, required this.options});
}
