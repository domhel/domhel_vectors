import 'dart:math';
import 'dart:typed_data';

import 'package:domhel_vectors/extensions/stochastics.dart';

// Task: n persons find n random beds. Q: P if 0, 1, 2, 3 persons find the right bed
void main() {
  final rng = Random(0);
  final nPersons = 3;

  const repetitions = 10000;
  final allResults = Uint8List(repetitions);
  int totalResult = 0;
  for (int i = 0; i < repetitions; ++i) {
    final result = simulate(nPersons, rng);
    allResults[i] = result;
    totalResult += result;
  }
  final average = totalResult / repetitions;
  print('Reps=$repetitions, Average correct hits: $average');
  final resultCount = <int, int>{};
  for (final count in allResults) {
    resultCount.update(
      count,
      (i) => i + 1,
      ifAbsent: () => 1,
    );
  }
  print(resultCount);
  // Result: 1, independent of nPersons
}

int simulate(int nPersons, Random rng) {
  final freeBedNumbers = List.generate(nPersons, (i) => i);
  final usedBedNumbers = <int>[];

  int numberOfCorrectBeds = 0;
  for (var k = 0; k < nPersons; ++k) {
    final randomBed = freeBedNumbers.randomChoice(rng);
    usedBedNumbers.add(randomBed);
    freeBedNumbers.remove(randomBed);
    if (randomBed == k) {
      numberOfCorrectBeds++;
    }
  }

  print("Number of correct beds: $numberOfCorrectBeds");
  print("Index=person number, value=bed number: $usedBedNumbers");
  return numberOfCorrectBeds;
}
