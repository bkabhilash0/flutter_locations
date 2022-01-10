import 'package:flutter/material.dart';
import 'package:native_features/providers/great_places.dart';
import 'package:native_features/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Places"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Consumer<GreatPlaces>(
          builder: (ctx, gplaces, ch) => gplaces.items.isEmpty
              ? ch!
              : ListView.builder(
                  itemCount: gplaces.items.length,
                  itemBuilder: (_, index) => Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.withOpacity(0.3)))),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundImage:
                                FileImage(gplaces.items[index].image),
                          ),
                          title: Text(gplaces.items[index].title),
                          onTap: () {},
                        ),
                      )),
          child: const Center(
            child: Text("No Places Found.. Add Some Places"),
          ),
        ));
  }
}
