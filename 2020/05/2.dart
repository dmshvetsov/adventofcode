import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:math';

final ROWS = [64, 32, 16, 8, 4, 2, 1];
final COLS = [4, 2, 1];
final B = 66;
final R = 82;

int soluciton(List<String> lines) {
  var oids = occupiedIDs(lines).toSet();
  var minID = oids.reduce(min);
  var maxID = oids.reduce(max);
  var allIDs = [];
  for (var i = minID; i <= maxID; i++) {
    if (!oids.contains(i)) {
      return i;
    }
  }
  return 0;
}

List<int> occupiedIDs(List<String> lines) {
  return lines.map((String line) {
    var row = 0;
    var col = 0;
    var idx = 0;
    line.runes.forEach((char) {
      if (char == B) {
        row += ROWS[idx];
      }
      if (char == R) {
        col += COLS[idx - 7];
      }
      idx += 1;
    });
    return row * 8 + col;
  }).toList();
}

readInput(filePath) {
 return new File(filePath).readAsLinesSync();
}

void main() {
  print(soluciton(readInput('input.txt')));
}
