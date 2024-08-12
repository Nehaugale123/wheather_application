import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/const.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

class Hellon extends StatefulWidget {
  const Hellon({super.key});

  @override
  State<Hellon> createState() => _HellonState();
}

class _HellonState extends State<Hellon> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  
  Weather? _weather;
  
  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("pune").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }
  
  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          _dateTimeInfo(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          _weatherIcon(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          _currentTemp(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          _extraInfo(),
        ],
      ),
    );
  }
  
  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
  
  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("hh:mm a").format(now),
          style: TextStyle(fontSize: 35),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: TextStyle(fontWeight: FontWeight.w100),
            ),
            Text(
              " ${DateFormat("d.M.y").format(now)}",
              style: TextStyle(fontWeight: FontWeight.w100),
            ),
          ],
        )
      ],
    );
  }
  
  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png'),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ],
    );
  }
  
  Widget _currentTemp() {
    return Text(
      '${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C',
      style: TextStyle(color: Colors.black, fontSize: 70, fontWeight: FontWeight.w900),
    );
  }
  
  Widget _extraInfo() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.20,
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}°C",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}°C",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)} m/s",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
