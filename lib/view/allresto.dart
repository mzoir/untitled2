import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Assuming this is the correct import for the ViewModel
import '../viewmodels/ViewRestoModel.dart';
import 'Profile.dart';

class RestoPage extends StatefulWidget {
  const RestoPage({super.key});

  @override
  State<RestoPage> createState() => _RestoPageState();
}

class _RestoPageState extends State<RestoPage> {
  @override
  void initState() {
    super.initState();
    // Load restaurants when the page is initialized
    Provider.of<RestaurantViewModel>(context, listen: false).loadRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Restaurants'),
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Raleway',
            fontSize: 23,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: "View Account",
            icon: const Icon(Icons.account_circle, color: Colors.black, size: 32),
            onPressed: () {
              final FirebaseAuth _auth = FirebaseAuth.instance;
              final user = _auth.currentUser;
              if (user != null) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfilePage(email: user.email.toString()),
                ));
              }
            },
          ),
        ],
      ),
      body: Consumer<RestaurantViewModel>(
        builder: (context, restaurantViewModel, child) {
          if (restaurantViewModel.restaurants.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: restaurantViewModel.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = restaurantViewModel.restaurants[index];
                return SizedBox(
                  height: 125,
                  child: Card(
                    color: Colors.blueGrey,
                    child: Center(
                      child: ListTile(
                        leading: Image.network(
                          restaurant.images[0], // Assuming 'images' is a List<String> in the model
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          restaurant.name,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          restaurant.rating.toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
