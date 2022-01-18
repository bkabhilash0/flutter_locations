import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:location/location.dart";
import 'package:native_features/screens/map_screen.dart';
import "../helpers/location_helper.dart";

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  const LocationInput({Key? key, required this.onSelectPlace})
      : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    if (locData.latitude == null || locData.longitude == null) {
      return;
    }
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude!, longitude: locData.longitude!);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
    widget.onSelectPlace(locData.latitude, locData.longitude);
  }

  Future<void> _selectOnMap() async {
    final selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => const MapScreen(
                  isSelecting: true,
                )));
    if (selectedLocation == null) {
      return;
    }
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.2),
              border: Border.all(color: Colors.grey.withOpacity(.5)),
              borderRadius: BorderRadius.circular(20)),
          width: double.infinity,
          child: _previewImageUrl == null
              ? const Text("No Location Choosen", textAlign: TextAlign.center)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(_previewImageUrl!,
                      fit: BoxFit.cover, width: double.infinity),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: Text(
                "Current Location",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: Text(
                "Select from Map",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            )
          ],
        )
      ],
    );
  }
}
