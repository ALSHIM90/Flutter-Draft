import 'package:chinese_universty_google_hackathon_2/logic/dyslexia/dyslexia_cubit.dart';
import 'package:chinese_universty_google_hackathon_2/presentaion/views/edu_play_landing_view.dart';
import 'package:chinese_universty_google_hackathon_2/services/dyslexia_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EduPlayApp());
}

class EduPlayApp extends StatelessWidget {
  const EduPlayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DyslexiaCubit>(
          create: (context) => DyslexiaCubit(DyslexiaService()),
        ),
      ],
      child: MaterialApp(
        title: 'EduPlay Kids Learning',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF6B6B)),
          useMaterial3: true,
        ),
        home: const EduPlayLandingView(),
      ),
    );
  }
}
