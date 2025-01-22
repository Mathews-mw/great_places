import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:great_places/environment.dart';

const GOOGLE_MAPS_API_KEY = 'AIzaSyAAMe9zzQm_mh76GwEpu99lLuscnnGR-bw';

class LocationUtil {
  static String generateLocationImagePreview({
    required double latitude,
    required double longitude,
  }) {
    final String staticUrl =
        'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_MAPS_API_KEY';

    return staticUrl;
  }

  static Future<String> getAddressFrom(LatLng position) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$GOOGLE_MAPS_API_KEY';

    final response = await http.get(Uri.parse(url));

    final data = await jsonDecode(response.body);

    final address = data['results'][0]['formatted_address'];

    return address;
  }
}
