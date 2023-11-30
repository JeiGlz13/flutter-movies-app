import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/domain/models/people/people.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(
      MoviesState.loading(TrendType.movie),
    ) MoviesState moviesState,
    @Default(
      PeopleState.loading(),
    ) PeopleState peopleState,
  }) = _HomeState;
}

@freezed
class MoviesState with _$MoviesState {
  const factory MoviesState.loading(TrendType type) = MoviesStateLoading;
  const factory MoviesState.failed(TrendType type) = MoviesStateFailed;
  const factory MoviesState.loaded({
    required List<TrendMedia> moviesAndSeries,
    required TrendType type,
  }) = MoviesStateLoaded;
}

@freezed
class PeopleState with _$PeopleState {
  const factory PeopleState.loading() = PeopleStateLoading;
  const factory PeopleState.failed() = PeopleStateFailed;
  const factory PeopleState.loaded({
    required List<People> people,
  }) = PeopleStateLoaded;
}