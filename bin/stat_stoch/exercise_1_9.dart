import 'dart:math';

typedef Result = Map<int, double>;

void main() {
  // From the example given:
  // const n1 = 2;
  // const p1 = 1 / 2;
  // final result1 = runExperiment(n1, p1);

  // printPDistribution(result1);
  // printCumulativeDistributionFunction(result1);

  // print('\n###############\n');

  // Task
  const n2 = 5;
  const p2 = 3 / 4;
  final result2 = runExperiment(n2, p2);

  // printPDistribution(result2);
  printCumulativeDistributionFunction(result2);
}

Result runExperiment(int n, double p) {
  final result = <int, double>{};
  for (int i = -n; i <= n; ++i) {
    result[i] = 0;
  }

  for (int x = 0; x <= n; ++x) {
    for (int y = 0; y <= n; ++y) {
      final z = x - y;
      final pZ = P(n, x, p) * P(n, y, p);
      // print('P(Z=$z) = $pZ');
      result[z] = (result[z] ?? 0) + pZ;
    }
  }

  // print(result);
  return result;
}

int factorial(int n) {
  int result = 1;
  for (int i = 1; i <= n; ++i) {
    result *= i;
  }
  // print('$n! = $result');
  return result;
}

double P(int n, int k, double p) {
  return (factorial(n) / (factorial(k) * factorial(n - k))) *
      pow(p, k) *
      pow(1 - p, n - k);
}

void printPDistribution(Result data) {
  for (final entry in data.entries) {
    print('${entry.key} ${entry.value}');
  }
}

void printCumulativeDistributionFunction(Result data) {
  double sum = 0;
  for (final entry in data.entries) {
    sum += entry.value;
    print('${entry.key} $sum');
  }
}
