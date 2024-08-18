import 'dart:convert';
import 'package:flutter/services.dart';  // For loading asset files
import '../models/resto.dart';

import 'package:flutter/material.dart';

class RestaurantViewModel extends ChangeNotifier {
  List<Restaurant> _restaurants = [];

  List<Restaurant> get restaurants => _restaurants;

  // Load data from JSON file
  Future<void> loadRestaurants() async {
    final String response = await rootBundle.loadString('images/resto.json');
    final data = await json.decode(response) as List;
    _restaurants = data.map((json) => Restaurant.fromJson(json)).toList();
    notifyListeners();
  }

  void addRestaurant(Restaurant restaurant) {
    _restaurants.add(restaurant);
    notifyListeners();
  }

  void removeRestaurant(String id) {
    _restaurants.removeWhere((restaurant) => restaurant.id == id);
    notifyListeners();
  }

  void updateRestaurant(Restaurant updatedRestaurant) {
    final index = _restaurants.indexWhere((restaurant) => restaurant.id == updatedRestaurant.id);
    if (index != -1) {
      _restaurants[index] = updatedRestaurant;
      notifyListeners();
    }
  }
}
