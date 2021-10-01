import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});
  final locationweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int tempr;
  String tempraturemessage ;
  String weathericon;
  String countryname;
@override
  void initState() {
  super.initState();
updateui(widget.locationweather);
}
void updateui(dynamic weatherdata){
  setState(() {

    if(weatherdata== null){
      tempr=0;
      weathericon='error';
      tempraturemessage='unable to get weather data';
      countryname='';
      return;
    }
  var temp = weatherdata['main']['temp'];
 tempr=temp.toInt();
  var cond = weatherdata['weather'][0]['id'];
 countryname = weatherdata['name'];
 weathericon = weather.getWeatherIcon(cond);
 tempraturemessage = weather.getMessage(tempr);
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherdata= await weather.getlocationweather();
                      updateui(weatherdata);

                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                     var typename = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }) );
                     if(typename!=null){
                       var weatherdata= await weather.getcityweather(typename);
                     updateui(weatherdata);
                     }

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$tempr°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$tempraturemessage in $countryname',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
