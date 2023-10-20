class Either<TLeft, TRight> {
  final TLeft? _left;
  final TRight? _right;
  final bool isLeft;

  Either._({
    required TLeft? left,
    required TRight? right,
    required this.isLeft,
  }) : _left = left, _right = right;

  factory Either.left(TLeft failure) {
    return Either._(left: failure, right: null, isLeft: true);
  }

  factory Either.right(TRight value) {
    return Either._(left: null, right: value, isLeft: false);
  }

  T when<T>(
    T Function(TLeft) left,
    T Function(TRight) right,
  ) {
    if (isLeft) {
      return left(_left!);
    } else {
      return right(_right!);
    }
  }
}