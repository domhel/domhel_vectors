typedef Dimension = List<int>;

extension DimensionUtils on Dimension {
  bool equals(Dimension other) =>
      length == other.length &&
      indexed.every((tuple) => tuple.$2 == other[tuple.$1]);

  bool get isNotZero => isNotEmpty && every((d) => d > 0);
}

class Matrix {
  final List<List<num>> value;

  const Matrix(this.value);

  Dimension get dimension => [value.length, value.firstOrNull?.length ?? 0];

  @override
  String toString() {
    return '[${value.join(',')}]';
  }

  @override
  bool operator ==(Object other) {
    return other is Matrix &&
        dimension.equals(other.dimension) &&
        value.indexed.every((row) => value[row.$1].indexed.every(
            (col) => value[row.$1][col.$1] == other.value[row.$1][col.$1]));
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}

extension MatrixOperations on Matrix {
  Matrix operator +(Matrix other) {
    return add(other);
  }

  Matrix add(Matrix other) {
    assert(dimension.equals(other.dimension), 'dimension mismatch');
    assert(dimension.isNotZero);
    return Matrix([
      for (var i = 0; i < value.length; ++i)
        [
          for (var j = 0; j < value[0].length; ++j)
            value[i][j] + other.value[i][j]
        ]
    ]);
  }

  Matrix multiply(Matrix other) {
    assert(dimension[1] == other.dimension[0],
        'inner and outer dimension mismatch');
    assert(dimension.isNotZero);
    final innerDimension = dimension[1];
    return Matrix([
      for (var i = 0; i < value.length; ++i)
        [
          for (var j = 0; j < other.value[0].length; ++j)
            [for (var a = 0; a < innerDimension; ++a) 
              value[i][a] * other.value[a][j]].fold(0, (aggr, el) => aggr + el)
        ]
    ]);
  }
}
