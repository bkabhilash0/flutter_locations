import 'package:flutter/material.dart';
import 'package:native_features/providers/great_places.dart';
import 'package:native_features/screens/add_place_screen.dart';
import 'package:native_features/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GreatPlaces(),
      child: MaterialApp(
        title: 'Location App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.indigo,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
                .copyWith(secondary: Colors.amber)),
        home: const PlacesListScreen(),
        routes: {AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen()},
      ),
    );
  }
}
