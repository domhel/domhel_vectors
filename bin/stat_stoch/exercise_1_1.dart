import 'dart:math';

import 'package:domhel_vectors/extensions/stochastics.dart';

// Task: n persons find n random beds. Q: How many persons find right bed?
// Guess: chance to find right bed: 1/n. => n persons * 1/n = 1;
void main() {
  final rng = Random(0);
  final nPersons = 10;

  const repetitions = 10000;
  int totalResult = 0;
  for (int i = 0; i < repetitions; ++i) {
    totalResult += simulate(nPersons, rng);
  }
  final average = totalResult / repetitions;
  print('Reps=$repetitions, Average correct hits: $average');
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
