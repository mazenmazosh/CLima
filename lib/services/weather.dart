import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apikey = '79a7e0b89e8ad2b6fe6cf7324888468e';
const openweathermap = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getcityweather(String cityname)async{
    networkhelper networkhel= await networkhelper('$openweathermap?q=$cityname&appid=$apikey&units=metric');
  var weatherdata=networkhel.getdata();
  return weatherdata;
  }

  Future<dynamic> getlocationweather()async{
    location l = location();
    await l.getcurrnetlocation();
    networkhelper networkhelp = networkhelper(
        '$openweathermap?lat=${l.latitude}&lon=${l.longitude}&appid=$apikey&units=metric');
    var weatherdata = await networkhelp.getdata();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
