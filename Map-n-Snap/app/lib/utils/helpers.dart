import "package:flutter/material.dart";
import "dart:convert";
import "package:http/http.dart" as http;

class Helpers {
  static String formatDate(DateTime date) {
    String day = date.day.toString();
    String month = date.month.toString();
    String year = date.year.toString();

    return "$day/$month/$year";
  }

  static void showMessage(BuildContext context, String message) {
    SnackBar popupMessage = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(popupMessage);
  }

  static Future<String> getPlaceName(double lat, double lng) async {
    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng',
      );
      final response = await http.get(
        url,
        headers: {'User-Agent': 'mapnsnap_app'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['address']['city'] ??
            data['address']['town'] ??
            data['address']['village'] ??
            data['address']['state'] ??
            "Saved Location";
      }
    } catch (e) {
      print("Lookup error: $e");
    }
    return "Saved Location";
  }
}
