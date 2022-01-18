import 'dart:io';

import 'package:flutter/material.dart';
import 'package:native_features/models/place.dart';
import 'package:native_features/providers/great_places.dart';
import 'package:native_features/screens/places_list_screen.dart';
import 'package:native_features/widgets/image_input.dart';
import 'package:native_features/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
   PlaceLocation? _pickedLocation;

  void _selectImage(File myPickedImage) {
    _pickedImage = myPickedImage;
  }

  void _selectPlace(double lat, double lon) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lon);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!,_pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add a Place")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(label: Text("Title")),
                  ),
                  const SizedBox(height: 10.0),
                  ImageInput(
                    onSelectImage: _selectImage,
                  ),
                  const SizedBox(height: 10.0),
                  LocationInput(onSelectPlace: _selectPlace)
                ],
              ),
            )),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: Theme.of(context).colorScheme.secondary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: _savePlace,
                icon: const Icon(Icons.add),
                label: const Text("Add Place"))
          ],
        ),
      ),
    );
  }
}
