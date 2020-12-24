import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:math';

final ROWS = [64, 32, 16, 8, 4, 2, 1];
final COLS = [4, 2, 1];
final B = 66;
final R = 82;

int soluciton(List<String> lines) {
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
  }).reduce(max);
}

readInput(filePath) {
 return new File(filePath).readAsLinesSync();
}

void main() {
  print(soluciton(readInput('example_input.txt'))); // should be 820
  print(soluciton(readInput('input.txt')));
}
