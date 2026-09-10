import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/dyslexia_service.dart';

abstract class DyslexiaState {}

class DyslexiaInitial extends DyslexiaState {}

class DyslexiaLoading extends DyslexiaState {}

class DyslexiaResult extends DyslexiaState {
  final bool hasDyslexiaRisk;
  DyslexiaResult(this.hasDyslexiaRisk);
}

class DyslexiaError extends DyslexiaState {
  final String message;
  DyslexiaError(this.message);
}

class DyslexiaCubit extends Cubit<DyslexiaState> {
  final DyslexiaService _service;

  DyslexiaCubit(this._service) : super(DyslexiaInitial());

  Future<void> loadAndPredict(List<double> userAnswers) async {
    emit(DyslexiaLoading());
    try {
      await _service.initModel();
      bool isAtRisk = _service.predict(userAnswers);
      emit(DyslexiaResult(isAtRisk));
    } catch (e) {
      emit(DyslexiaError(e.toString()));
    }
  }
}
