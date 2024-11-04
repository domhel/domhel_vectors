typedef Dimension = List<int>;

class DimensionException implements Exception {
  String? message;
  DimensionException({this.message});
}

extension DimensionUtils on Dimension {
  bool equals(Dimension other) =>
      length == other.length &&
      indexed.every((tuple) => tuple.$2 == other[tuple.$1]);

  bool get isNotZero => isNotEmpty && every((d) => d > 0);
}

extension ListMatrixExtension on List<List<num>> {
  Matrix asMatrix() {
    return Matrix(this);
  }
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

  Matrix copyWithChangedElement((int i, int j) coords, num newValue) {
    return Matrix(
      List.generate(
        value.length,
        (i1) => List.generate(
          value[0].length,
          (j1) =>
              (i1 == coords.$1 && j1 == coords.$2) ? newValue : value[i1][j1],
        ),
      ),
    );
  }
}

extension MatrixOperations on Matrix {
  List<num> operator [](int i) {
    return value[i];
  }

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

  Matrix operator *(Matrix other) {
    return multiply(other);
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
            [
              for (var a = 0; a < innerDimension; ++a)
                value[i][a] * other.value[a][j]
            ].fold(0, (aggr, el) => aggr + el),
        ],
    ]);
  }

  bool get isSquare => dimension[0] == dimension[1];

  Matrix removeColAndRow(int i, int j) {
    return Matrix(
      [
        for (final c in List.generate(dimension[0], (c) => c)..removeAt(i))
          [
            for (final r in List.generate(dimension[1], (r) => r)..removeAt(j))
              value[c][r],
          ],
      ],
    );
  }

  num get det {
    assert(dimension.isNotZero);
    assert(isSquare);
    if (!isSquare) {
      throw DimensionException();
    }

    if (dimension[0] == 2) {
      return value[0][0] * value[1][1] - value[0][1] * value[1][0];
    } else {
      // to be changed to non-recursive
      return List.generate(value.length, (j) => j)
          .map((j) =>
              (j % 2 == 0 ? 1 : -1) * value[0][j] * removeColAndRow(0, j).det)
          .fold(0, (aggr, el) => aggr + el);
    }
  }

  bool get isInvertible => isSquare && det != 0;
}
