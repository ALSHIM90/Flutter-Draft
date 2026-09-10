import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/dyslexia/dyslexia_cubit.dart';
import '../../models/question_model.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<double> _userAnswers = [];

  final List<QuestionModel> _questions = [
    QuestionModel(
      text: "هل يجد الطفل صعوبة في تمييز الحروف المتشابهة (مثل ب / ت / ث)؟",
      options: {"أبداً": 0.0, "أحياناً": 1.0, "غالباً": 2.0, "دائماً": 3.0},
    ),
    QuestionModel(
      text: "ما مدى بطء الطفل في القراءة مقارنة بأقرانه؟",
      options: {"طبيعي": 0.0, "بطيء قاطعاً": 1.0, "بطيء جداً": 2.0},
    ),
    QuestionModel(
      text: "هل يعاني من صعوبة في تذكر الكلمات أو الأرقام بالترتيب؟",
      options: {"لا": 0.0, "نعم": 1.0},
    ),
  ];

  void _selectAnswer(double value) {
    setState(() {
      _userAnswers.add(value);
    });

    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // عند الانتهاء من جميع الأسئلة، نقوم بإرسال الإجابات إلى الـ Cubit
      context.read<DyslexiaCubit>().loadAndPredict(_userAnswers);
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        if (_userAnswers.isNotEmpty) {
          _userAnswers.removeLast();
        }
      });

      if (_pageController.hasClients) {
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("سؤال ${_currentIndex + 1} من ${_questions.length}"),
        leading: _currentIndex > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _previousQuestion,
                tooltip: "السؤال السابق",
              )
            : null, // يخفي الزر إذا كنا في السؤال الأول
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: (_currentIndex + 1) / _questions.length,
          ),
        ),
      ),
      body: BlocConsumer<DyslexiaCubit, DyslexiaState>(
        listener: (context, state) {
          if (state is DyslexiaError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is DyslexiaLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("جاري تحليل الإجابات بحسابات الذكاء الاصطناعي..."),
                ],
              ),
            );
          }

          if (state is DyslexiaResult) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      state.hasDyslexiaRisk
                          ? Icons.warning_amber_rounded
                          : Icons.check_circle_outline,
                      size: 80,
                      color: state.hasDyslexiaRisk
                          ? Colors.orange
                          : Colors.green,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.hasDyslexiaRisk
                          ? "توجد مؤشرات قد تدل على صعوبة القراءة، يُنصح باستشارة أخصائي."
                          : "النتائج ممتازة، ولا تظهر مؤشرات لعسر القراءة.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // لمنع السحب باليد
            itemCount: _questions.length,
            itemBuilder: (context, index) {
              final question = _questions[index];
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      question.text,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ...question.options.entries.map(
                      (entry) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () => _selectAnswer(entry.value),
                          child: Text(
                            entry.key,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
