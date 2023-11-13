import 'package:freezed_annotation/freezed_annotation.dart';

part 'either.freezed.dart';

@freezed
class Either<TError, TSuccess> with _$Either<TError, TSuccess> {

  factory Either.error({ required TError value }) = Error;

  factory Either.success({ required TSuccess value }) = Success;
}