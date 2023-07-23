import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/errors/expection.dart';
import 'package:tdd/core/errors/failure.dart';
import 'package:tdd/data/models/weather_model.dart';
import 'package:tdd/data/repositories/weather_repository_impl.dart';
import 'package:tdd/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late WeatherRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = WeatherRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

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

  group('get current weather', () {
    const tCityName = 'Sinjai';

    test(
      'should return current weather when a call to data source is successful',
      () async {
        when(mockRemoteDataSource.getCurrentWeather(tCityName)).thenAnswer(
          (_) async => tWeatherModel,
        );

        final result = await repository.getCurrentWeather(tCityName);

        verify(mockRemoteDataSource.getCurrentWeather(tCityName));
        expect(result, equals(const Right(tWeather)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        when(mockRemoteDataSource.getCurrentWeather(tCityName)).thenThrow(
          ServerException(),
        );

        final result = await repository.getCurrentWeather(tCityName);

        verify(mockRemoteDataSource.getCurrentWeather(tCityName));
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        when(mockRemoteDataSource.getCurrentWeather(tCityName)).thenThrow(
          const SocketException('Failed to connect to the network'),
        );

        final result = await repository.getCurrentWeather(tCityName);

        verify(mockRemoteDataSource.getCurrentWeather(tCityName));
        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      },
    );
  });
}
