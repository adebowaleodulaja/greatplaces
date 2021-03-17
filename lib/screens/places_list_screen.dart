import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacesScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctxt, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text("Got no places yet, start adding some!"),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.listOfPlaces.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlaces.listOfPlaces.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(greatPlaces.listOfPlaces[i].image),
                          ),
                          title: Text(greatPlaces.listOfPlaces[i].title),
                          subtitle: Text(greatPlaces.listOfPlaces[i].location.address),
                          onTap: () {},
                        ),
                      ),
              ),
      ),
    );
  }
}
