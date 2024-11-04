import 'dart:math';

void main() {
  final rng = Random(0);
  for (var nImages = 0; nImages < 20; ++nImages) {
    const repetitions = 100000;
    int totalResult = 0;
    for (int i = 0; i < repetitions; ++i) {
      totalResult += simulate(nImages, rng);
    }
    final average = totalResult / repetitions;
    // print('n=$nImages, reps=$repetitions, Average tries: $average');
    print('$nImages, $average');
    // Result: 297.78 = 4.72 * 63 images
    // Result: 124.80 = 4.03 * 31 images
    // Result:  54.10 = 3.38 * 16 images
  }
}

int simulate(int nImages, Random rng) {
  final necessaryImages = List.generate(nImages, (i) => i);
  int numTries = 0;
  while (necessaryImages.isNotEmpty) {
    final image = rng.nextInt(nImages);
    necessaryImages.remove(image);
    numTries++;
  }
  return numTries;
}
