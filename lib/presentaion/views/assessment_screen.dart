import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/dyslexia/dyslexia_cubit.dart';

class AssessmentScreen extends StatelessWidget {
  final List<double> userScores = [1.0, 2.5, 0.0, 3.2]; // مدخلات الاختبار

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تقييم عسر القراءة")),
      body: Center(
        child: BlocConsumer<DyslexiaCubit, DyslexiaState>(
          listener: (context, state) {
            if (state is DyslexiaError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is DyslexiaLoading) {
              return const CircularProgressIndicator();
            } else if (state is DyslexiaResult) {
              return Text(
                state.hasDyslexiaRisk
                    ? "هناك مؤشرات تتطلب المتابعة مع أخصائي"
                    : "النتيجة طبيعية، لا توجد مؤشرات لعسر القراءة",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              );
            }

            return ElevatedButton(
              onPressed: () {
                context.read<DyslexiaCubit>().loadAndPredict(userScores);
              },
              child: const Text("حساب النتيجة"),
            );
          },
        ),
      ),
    );
  }
}
