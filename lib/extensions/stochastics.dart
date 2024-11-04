import 'dart:math';

extension StochasticsExtension<T> on List<T> {
  T randomChoice([Random? rng]) => this[(rng ?? Random(0)).nextInt(length)];
  int randomIndex([Random? rng]) => (rng ?? Random(0)).nextInt(length);
}
