import 'package:flutter/material.dart';
import 'package:untitled2/models/hotel.dart';

class HotelViewModel with ChangeNotifier {
  List<Hotel> _hotels = [];
  Set<int> _favoriteHotels = {};

  List<Hotel> get hotels => _hotels;
  Set<int> get favoriteHotels => _favoriteHotels;

  Future<void> loadHotels() async {
    _hotels = await Hotel.loadHotels();
    notifyListeners();
  }

  void toggleFavorite(int index) {
    if (_favoriteHotels.contains(index)) {
      _favoriteHotels.remove(index);
    } else {
      _favoriteHotels.add(index);
    }
    notifyListeners();
  }

  List<Hotel> getFavoriteHotels() {
    return _favoriteHotels.map((index) => _hotels[index]).toList();
  }
}
