import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:tdd/data/datasources/remote_data_source.dart';
import 'package:tdd/domain/repositories/weather_repository.dart';

@GenerateMocks(
  [
    WeatherRepository,
    RemoteDataSource,
  ],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {}
