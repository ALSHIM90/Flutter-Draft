abstract class EduPlayEvent {
  const EduPlayEvent();
}

class LoadLandingDataEvent extends EduPlayEvent {}

class SelectCategoryEvent extends EduPlayEvent {
  final String category;
  const SelectCategoryEvent(this.category);
}
