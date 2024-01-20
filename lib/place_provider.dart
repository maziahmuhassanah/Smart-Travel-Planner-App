import 'package:flutter/foundation.dart';
import 'place_model.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => _places;

  void addPlace(Place place) {
    _places.add(place);
    notifyListeners();
  }
}
