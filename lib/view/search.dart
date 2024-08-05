import 'package:flutter/material.dart';
import 'attraction_page.dart';
import 'home_page.dart';
import 'hotels.dart';
import 'dart:io';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [
    'hotels',
    'attraction',
    'Errachidia  ',
    'erfoud',
    'dades',
    'merzouga',
    'gorges',
  ];
  List<String> _filteredSuggestions = [];
  String? error;
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _filteredSuggestions = _suggestions
          .where((suggestion) =>
          suggestion.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Container(
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center Column content vertically
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: const Text(
                  'Tourism',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 30.5,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextField(
                controller: _searchController,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 27),
                  labelText: 'Search for somthing....',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                        width: 2.0, color: Color(0xffa9a9a8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                        width: 2.0, color: Color(0xff0a43ff)),
                  ),
                  prefixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.yellow,
                      size: 30.0,
                    ),
                    onPressed: () {
                      // Add your onPressed code here!
                      if (_searchController.text == '') {
                        setState (() {
                          error = "error u must type somthing ";
                        });
                      } else {
                         print('searched');
                      };
                      print('Icon button pressed');
                    },
                  ),


                    suffixIcon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HoMepa(email: '')),
                      );
                    },
                    child: Icon(
                      Icons.home,
                      color: Colors.black ,
                      size: 30.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredSuggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(

                      title: Text(textAlign: TextAlign.justify,
                        _filteredSuggestions[index],
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),
                      ),
                      onTap: () {
                        if (_filteredSuggestions[index] == 'hotels') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HotelsPage()),
                          );
                        }
                        else if (_filteredSuggestions[index] == 'attraction') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AttractionsPage()),
                          );
                        }

                        print('Selected: ${_filteredSuggestions[index]}');
                      }
                      );

                  },
                ),
              ),
              if (error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    error!,
                    style: const TextStyle(color: Colors.red,fontSize: 26),
                  ),
                ),


            ],
          ),
        ),

    );
  }
}
