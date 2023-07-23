import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/data/models/weather_model.dart';
import 'package:tdd/domain/entities/weather.dart';

import '../../helpers/json_reader.dart';

void main() {
  const tWeatherModel = WeatherModel(
    cityName: 'Sinjai',
    main: 'Clouds',
    description: 'overcast clouds',
    iconCode: '04n',
    temperature: 297.17,
    pressure: 1013,
    humidity: 83,
  );

  const tWeather = Weather(
    cityName: 'Sinjai',
    main: 'Clouds',
    description: 'overcast clouds',
    iconCode: '04n',
    temperature: 297.17,
    pressure: 1013,
    humidity: 83,
  );

  group('to entity', () {
    test(
      'should be a subclass of weather entity',
      () async {
        // assert
        final result = tWeatherModel.toEntity();
        expect(result, equals(tWeather));
      },
    );
  });

  group('from json', () {
    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/dummy_data/dummy_weather_response.json'),
        );

        // act
        final result = WeatherModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tWeatherModel));
      },
    );
  });

  group('to json', () {
    test(
      'should return a json map containing proper data',
      () async {
        // act
        final result = tWeatherModel.toJson();

        // assert
        final expectedJsonMap = {
          'weather': [
            {'main': 'Clouds', 'description': 'overcast clouds', 'icon': '04n'}
          ],
          'main': {'temp': 297.17, 'pressure': 1013, 'humidity': 83},
          'name': 'Sinjai'
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
