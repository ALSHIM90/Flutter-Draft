import '../../models/course_model.dart';

abstract class EduPlayState {
  const EduPlayState();
}

class EduPlayInitialState extends EduPlayState {}

class EduPlayLoadingState extends EduPlayState {}

class EduPlayLoadedState extends EduPlayState {
  final List<CourseModel> courses;
  final String selectedCategory;

  const EduPlayLoadedState({
    required this.courses,
    required this.selectedCategory,
  });

  EduPlayLoadedState copyWith({
    List<CourseModel>? courses,
    String? selectedCategory,
  }) {
    return EduPlayLoadedState(
      courses: courses ?? this.courses,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class EduPlayErrorState extends EduPlayState {
  final String message;
  const EduPlayErrorState(this.message);
}
