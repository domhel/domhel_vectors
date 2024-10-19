import 'package:domhel_vectors/models/matrix.dart';
import 'package:test/test.dart';

void main() {
  test('dimension', () {
    const Dimension a = [1, 2, 3];
    const Dimension b = [1, 2, 3];
    const Dimension c = [1, 2, 3, 4];
    const Dimension d = [3, 2, 1];
    const Dimension e = [];
    expect(a.equals(b), true);
    expect(a.equals(c), false);
    expect(a.equals(d), false);
    expect(e.equals([]), true);
  });

  test('matrix add', () {
    const A = Matrix([
      [1, 1],
      [1, 1],
    ]);
    const B = Matrix([
      [0, 1],
      [2, 3],
    ]);
    const C = Matrix([
      [0, 1],
      [2, 3],
      [4, 5],
    ]);
    const D = Matrix([
      [0, 1, 2],
      [3, 4, 5],
    ]);

    expect(
      A + B,
      Matrix(
        [
          [1, 2],
          [3, 4],
        ],
      ),
    );
  });

  test('matrix multiplication', () {
    const A = Matrix(
      [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
      ],
    );
    const B = Matrix(
      [
        [1, 0, 0],
        [0, 2, 0],
        [0, 0, 1],
      ],
    );

    expect(
      A.multiply(B),
      Matrix(
        [
          [1, 4, 3],
          [4, 10, 6],
          [7, 16, 9],
        ],
      ),
    );

    const C = Matrix(
      [
        [1],
        [2],
      ],
    );
    const D = Matrix(
      [
        [3, 4],
      ],
    );
    expect(
      C * D,
      Matrix(
        [
          [
            3,
            4,
          ],
          [
            6,
            8,
          ],
        ],
      ),
    );
  });

  test('matrix determinant', () {
    const A = Matrix([
      [1, 0, -1],
      [0, 2, 1],
      [1, 3, 1],
    ]);
    expect(A.det, 1);
    expect(A.isInvertible, true);

    const B = Matrix([
      [-1, 2, 3, 4],
      [2, -3, 4, 5],
      [3, 4, -5, 6],
      [4, 5, 6, -7]
    ]);
    expect(B.det, -2816);
    expect(B.isInvertible, true);

    const C = Matrix([
      [1, -4, 0],
      [1, 4, 4],
      [2, 2, 5]
    ]);
    expect(C.det, 0);
    expect(C.isInvertible, false);
  });
}
