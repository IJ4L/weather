import 'package:dartz/dartz.dart';
import 'package:tdd/core/errors/failure.dart';

import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}
