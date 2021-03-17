import 'dart:convert';

import 'package:http/http.dart' as http;


const GOOGLE_API_KEY = "";

class LocationHelper {
  static String generateLocationPreviewImage({double latitude, double longitude,}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude,NY&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }

  static Future<String> getPlaceAddress(double lat, double long) async{
    final url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$GOOGLE_API_KEY";
    final response = await http.get(Uri.parse(url));
    print("URL Response=> "+json.encode(response.body));
    return json.decode(response.body)["results"][0]["formatted_address"]; //Get the Key, The first result since there will be more than one, then the formatted_address key.
  }
}