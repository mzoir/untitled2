import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/viewmodels/attraction_viewmodel.dart';
import 'favatt.dart';
import 'Profile.dart';
import 'attraction_details.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AttractionsPage extends StatefulWidget {
  @override
  _AttractionsPageState createState() => _AttractionsPageState();
}

class _AttractionsPageState extends State<AttractionsPage> {
  @override
  void initState() {
    super.initState();
    // Load attractions when the page is initialized
    Provider.of<AttractionViewModel>(context, listen: false).loadAttractions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.blue,
      appBar: AppBar(
        backgroundColor:  Colors.blue,
        title: Text('Attractions'),
        titleTextStyle: TextStyle(color: Colors.white,fontFamily: 'raleway',fontSize: 23,fontWeight: FontWeight.bold),
        centerTitle: true,

        actions : [
        IconButton(
        tooltip: "viewaccount",
        icon:
        const Icon(Icons.account_circle, color: Colors.white, size: 32),
        onPressed: () {
          final FirebaseAuth _auth = FirebaseAuth.instance;
          final user = FirebaseAuth.instance.currentUser;
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProfilePage(email:  user!.email.toString()),
          ));


        },
      ),
        ],
      ),
      body: Consumer<AttractionViewModel>(
        builder: (context, attractionViewModel, child) {
          if (attractionViewModel.attractions.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: attractionViewModel.attractions.length,
              itemBuilder: (context, index) {
                var attraction = attractionViewModel.attractions[index];
                bool isFavorite =
                    attractionViewModel.favoriteAttractions.contains(index);
                return Card(

                  color: Colors.blueGrey,
                  child: ListTile(
                    leading: Image.asset(
                      attraction.image[0],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    title: Text(attraction.name,style :TextStyle(color:Colors.white)),
                    subtitle: Text(attraction.location,style :TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                    trailing: IconButton(
                      onPressed: () {
                        attractionViewModel.toggleFavorite(index);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return isFavorite
                                ? AlertDialog(
                              elevation: 2,
                              content: Text("removed from favourite"),
                              contentTextStyle:
                              const TextStyle(color: Colors.red),
                              actions: [
                                BackButton(
                                  color: Colors.black,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            )
                                : AlertDialog(
                              elevation: 2,
                              content: Text("added to favourite"),
                              contentTextStyle:
                              const TextStyle(color: Colors.green),
                              actions: [
                                BackButton(
                                  color: Colors.black,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(
                        size: 34,
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                      ),
                      color: isFavorite ? Colors.red : Colors.red,
                    ),

                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AttractionDetails(item:attraction ),
                        ));
                      },

                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoriteAttractionsPage()),
          );
        },
        child: Icon(Icons.favorite),
      ),
    );
  }
}
