import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:native_features/constants.dart';

const GOOGLE_API_KEY = Constants.GOOGLE_API_KEY;
class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&amp;key=$GOOGLE_API_KEY");
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]["formatted_address"];
  }
}
