import 'package:dartz/dartz.dart';
import 'package:tdd/core/errors/failure.dart';
import 'package:tdd/domain/entities/weather.dart';
import 'package:tdd/domain/repositories/weather_repository.dart';

class GetCurrentWaether {
  final WeatherRepository repository;

  GetCurrentWaether(this.repository);

  Future<Either<Failure, Weather>> execute(String cityName) {
    return repository.getCurrentWeather(cityName);
  }
}
