import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd/domain/usecases/get_current_weather.dart';
import 'package:tdd/presentation/bloc/weather_state.dart';
import 'package:rxdart/rxdart.dart';

part 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWaether _getCurrentWaether;

  WeatherBloc(this._getCurrentWaether) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {
        final cityName = event.cityName;

        emit(WeatherLoading());

        final result = await _getCurrentWaether.execute(cityName);

        result.fold(
          (failure) => emit(WeatherError(failure.message)),
          (data) => emit(WeatherHasData(data)),
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
