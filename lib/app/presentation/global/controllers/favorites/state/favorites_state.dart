import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  factory FavoritesState.loading() = FavoritesStateLoading;
  factory FavoritesState.failed() = FavoritesStateFailed;
  factory FavoritesState.loaded({
    required Map<int, TrendMedia> movies,
    required Map<int, TrendMedia> series,
  }) = FavoritesStateLoaded;
}