import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies_app/app/domain/models/movie/movie.dart';

part 'movie_state.freezed.dart';

@freezed
class MovieState with _$MovieState {
  factory MovieState.loading() = MovieStateLoading;
  factory MovieState.failed() = MovieStateFailed;
  factory MovieState.loaded(Movie movie) = MovieStateLoaded;
}