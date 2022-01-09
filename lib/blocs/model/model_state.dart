import 'package:galss/models/city.dart';
import 'package:galss/models/country.dart';
import 'package:galss/models/model.dart';

class ModelState {
  final Model? model;

  const ModelState({this.model});

  ModelState copyWith(Model model) {
    return ModelState(
        model: Model(
            // id: this.model.id,
            ));
  }
}
