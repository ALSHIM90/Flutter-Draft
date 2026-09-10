import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/dyslexia/dyslexia_cubit.dart';
import '../../logic/edu_play/edu_play_bloc.dart';
import '../../logic/edu_play/edu_play_event.dart';
import '../../logic/edu_play/edu_play_state.dart';
import '../../services/dyslexia_service.dart';
import '../widgets/course_card.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/feature_card.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import 'questions_screen.dart'; // 👈 تأكدي أن هذا المسار مطابق لمكان ملف QuestionsScreen لديكم

class EduPlayLandingView extends StatelessWidget {
  const EduPlayLandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EduPlayBloc()..add(LoadLandingDataEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FC),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // 1. Navigation Bar
              const CustomNavBar(),

              // 2. Hero Section
              const HeroSection(),

              // 3. Features Section
              const _FeaturesSection(),

              const SizedBox(height: 40),

              // 4. Featured Courses Section
              BlocConsumer<EduPlayBloc, EduPlayState>(
                listener: (context, state) {
                  if (state is EduPlayErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  if (state is EduPlayLoadingState) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is EduPlayLoadedState) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Featured Courses',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3142),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 220,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.courses.length,
                              itemBuilder: (context, index) {
                                return CourseCard(course: state.courses[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 60),

              // 5. Footer Section
              const FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget خاص بقسم المميزات لتنظيم الكود
class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Column(
        children: [
          const Text(
            'Why Choose EduPlay?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3142),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Everything your child needs for a fun and engaging learning journey.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: const [
              FeatureCard(
                title: 'Interactive Games',
                description: 'Playful learning experiences designed to keep kids motivated and engaged.',
                icon: Icons.sports_esports_rounded,
                cardColor: Color(0xFFFF6B6B),
              ),
              FeatureCard(
                title: 'Safe Environment',
                description: '100% ad-free and kid-safe content curated by educational specialists.',
                icon: Icons.verified_user_rounded,
                cardColor: Color(0xFF4ECDC4),
              ),
              FeatureCard(
                title: 'Expert Curriculums',
                description: 'Skill-building lessons aligned with early childhood development goals.',
                icon: Icons.psychology_rounded,
                cardColor: Color(0xFFFFE66D),
              ),
              FeatureCard(
                title: 'Progress Tracking',
                description: 'Detailed insights for parents to track growth and learning achievements.',
                icon: Icons.insights_rounded,
                cardColor: Color(0xFF1A535C),
              ),
            ],
          ),
          const SizedBox(height: 36),

          // 👈 زر بدء التقييم المضاف حديثاً
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B6B),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4,
            ),
            icon: const Icon(Icons.assignment_turned_in_rounded, size: 24),
            label: const Text(
              'Start Assessment Test',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => DyslexiaCubit(DyslexiaService()),
                    child: const QuestionsScreen(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
