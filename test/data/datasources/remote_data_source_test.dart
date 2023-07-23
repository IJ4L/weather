import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:tdd/core/constants/constant.dart';
import 'package:tdd/core/errors/expection.dart';
import 'package:tdd/data/datasources/remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/data/models/weather_model.dart';
import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

import 'package:http/http.dart' as http;

void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getCurrentWeather', () {
    const tCityName = "Sinjai";
    final tWeatherModel = WeatherModel.fromJson(
      jsonDecode(readJson("helpers/dummy_data/dummy_weather_response.json")),
    );

    test(
      'should return weather model when the response code is 200',
      () async {
        when(
          mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(tCityName))),
        ).thenAnswer(
          (_) async => http.Response(
            readJson("helpers/dummy_data/dummy_weather_response.json"),
            200,
          ),
        );

        final result = await dataSource.getCurrentWeather(tCityName);

        expect(result, equals(tWeatherModel));
      },
    );

    test(
        'should throw a server exception when the response code is 404 or other',
        () async {
      when(
        mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(tCityName))),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      final call = dataSource.getCurrentWeather(tCityName);

      expect(call, throwsA(isA<ServerException>()));
    });
  });
}
