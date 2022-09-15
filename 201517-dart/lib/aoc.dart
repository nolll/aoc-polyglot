import 'dart:io';
import 'dart:convert';

run() async {
  var rows = await readLines();
  var containers = parseContainers(rows);

  var part1Combinations = getCombinations(containers, 150);
  print(part1Combinations.length);

  var part2Combinations = getCombinationsWithLeastContainers(containers, 150);
  print(part2Combinations.length);
}

List<EggnogContainer> parseContainers(List<String> rows) {
  return rows.asMap().entries.map((entry) {
    return EggnogContainer(entry.key, int.parse(entry.value));
  }).toList();
}

List<List<EggnogContainer>> getCombinations(List<EggnogContainer> containers, int targetVolume) {
  var combinations = getAllCombinations(containers);
  return combinations.where((o) => getSum(o) == targetVolume).toList();
}

int getSum(List<EggnogContainer> combination) {
  return combination.map((o) => o.volume).reduce((value, element) => value + element);
}

List<List<EggnogContainer>> getCombinationsWithLeastContainers(List<EggnogContainer> containers, int targetVolume) {
  var combinations = getCombinations(containers, targetVolume);
  combinations.sort((a, b) => a.length.compareTo(b.length));
  var smallestCount = combinations.first.length;
  return combinations.where((o) => o.length == smallestCount).toList();
}

List<List<EggnogContainer>> getAllCombinations<T>(List<EggnogContainer> list) {
  var result = <List<EggnogContainer>>[];
  result.add(<EggnogContainer>[]);
  result.last.add(list[0]);
  if (list.length == 1) {
    return result;
  }
  var tailCombos = getAllCombinations(list.skip(1).toList());
  for (var combo in tailCombos) {
    result.add(List<EggnogContainer>.from(combo));
    combo.add(list[0]);
    result.add(List<EggnogContainer>.from(combo));
  }
  return result;
}

Future<List<String>> readLines() async {
  var s = await File('./resources/input.txt').readAsString();
  var lineSplitter = LineSplitter();
  return lineSplitter.convert(s);
}

class EggnogContainer {
  int id;
  int volume;

  EggnogContainer(this.id, this.volume);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is EggnogContainer && other.id == id;
  }
}
