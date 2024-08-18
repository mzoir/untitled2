import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/viewmodels/attraction_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/viewmodels/attraction_viewmodel.dart';

class FavoriteAttractionsPage extends StatefulWidget {
  @override
  State<FavoriteAttractionsPage> createState() => _FavoriteAttractionsPageState();
}

class _FavoriteAttractionsPageState extends State<FavoriteAttractionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Attractions'),
        centerTitle: true,
      ),
      body: Consumer<AttractionViewModel>(
        builder: (context, attractionViewModel, child) {
          var favoriteAttractions = attractionViewModel.getFavoriteAttrs();
          if (favoriteAttractions.isEmpty) {
            return Center(child: Text('No favorite attractions yet.'));
          } else {
            return ListView.builder(
              itemCount: favoriteAttractions.length,
              itemBuilder: (context, index) {
                var attraction = favoriteAttractions[index];
                return Card(
                  color: Colors.yellow,
                  child: ListTile(
                    leading: Image.asset(
                      attraction.image[0],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    title: Text(attraction.name),
                    subtitle: Text(attraction.location),
                    trailing: ElevatedButton(
                      child: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          attractionViewModel.toggleFavorite(attractionViewModel.attractions.indexOf(attraction));

                        });
                      },
                    ),
                    onTap: () {
                      // Handle onTap event, maybe navigate to a detail page
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

