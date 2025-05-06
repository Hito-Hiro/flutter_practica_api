import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:practica_api/models/weather_model.dart';

class WeatherServices {

  static const BASE_URL ='https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherServices(this.apiKey);

  Future<Weather> getWeather(String nombreCiudad) async{
    final response = await http.get(Uri.parse('$BASE_URL?q=$nombreCiudad&appid=$apiKey&units=metric'));

    if (response.statusCode == 200){
      return Weather.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('No pudimos obtener la información del clima');
    }
  }

  Future<String> GetCurrentWeather() async{
    LocationPermission permission = await Geolocator.checkPermission();

    //obtener permisos del usuario
    if( permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    //obtener la ubicación actual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    String? ciudad = placemarks[0].locality;

    return ciudad ?? "";
  }
}