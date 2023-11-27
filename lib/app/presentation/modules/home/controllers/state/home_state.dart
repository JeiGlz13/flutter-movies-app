import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required bool isLoading,
    List<TrendMedia>? moviesAndSeries,
    @Default(TrendType.movie) TrendType type,
  }) = _HomeState;
}