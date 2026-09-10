import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/course_model.dart';
import 'edu_play_event.dart';
import 'edu_play_state.dart';

class EduPlayBloc extends Bloc<EduPlayEvent, EduPlayState> {
  EduPlayBloc() : super(EduPlayInitialState()) {
    on<LoadLandingDataEvent>(_onLoadLandingData);
    on<SelectCategoryEvent>(_onSelectCategory);
  }

  void _onLoadLandingData(
    LoadLandingDataEvent event,
    Emitter<EduPlayState> emit,
  ) async {
    emit(EduPlayLoadingState());
    try {
      // محاكاة جلب البيانات
      await Future.delayed(const Duration(milliseconds: 500));

      final mockCourses = [
        const CourseModel(
          id: '1',
          title: 'Interactive Math & Logic',
          ageGroup: 'Ages 3 - 5',
          description: 'Fun puzzles and counting games for early learners.',
          iconPath: 'assets/icons/math.png',
          colorHex: '#FF6B6B',
        ),
        const CourseModel(
          id: '2',
          title: 'Creative Arts & Drawing',
          ageGroup: 'Ages 6 - 8',
          description: 'Unleash creativity with guided drawing and colors.',
          iconPath: 'assets/icons/art.png',
          colorHex: '#4ECDC4',
        ),
        const CourseModel(
          id: '3',
          title: 'Early Science Explorers',
          ageGroup: 'Ages 9 - 12',
          description: 'Discover nature, space, and simple experiments.',
          iconPath: 'assets/icons/science.png',
          colorHex: '#FFE66D',
        ),
      ];

      emit(EduPlayLoadedState(courses: mockCourses, selectedCategory: 'All'));
    } catch (e) {
      emit(EduPlayErrorState('Failed to load EduPlay data: ${e.toString()}'));
    }
  }

  void _onSelectCategory(
    SelectCategoryEvent event,
    Emitter<EduPlayState> emit,
  ) {
    if (state is EduPlayLoadedState) {
      final currentState = state as EduPlayLoadedState;
      emit(currentState.copyWith(selectedCategory: event.category));
    }
  }
}
