use std::collections::HashSet;
use std::fs::File;
use std::io::{BufRead, BufReader};

// range a..=Z will will start with a char code (i32) 97 (a) to 122 (z) and continues from 65 (A) to 90 (Z)
// to put A over z add 58 to every char in A..=Z range
// and deduct CHARS_START from every char i32 value
const CHARS_START: i32 = 96;

fn find_char_in_both_halfs(line: &str) -> Option<char> {
    let mut set = HashSet::new();
    let (left_part, right_part) = line.split_at(line.len() / 2);
    for c in left_part.chars() {
        set.insert(c);
    }
    for c in right_part.chars() {
        if set.contains(&c) {
            return Some(c);
        }
    }
    None
}

fn to_priority(item: Option<char>) -> i32 {
    match item {
        Some(item) => {
            let diff = (item as i32 - CHARS_START) as i32;
            if diff < 0 {
                diff + 58
            } else {
                diff 
            }
        },
        None => 0,
    }
}

fn solution(reader: BufReader<File>) -> i32 {
    let mut sum = 0;
    for line_result in reader.lines() {
        sum = sum + to_priority(find_char_in_both_halfs(&line_result.unwrap()));
    }
    sum
}

fn main() {
    let test_file = File::open("./03/test.txt").unwrap();
    assert_eq!(solution(BufReader::new(test_file)), 157);

    let input_file = File::open("./03/input.txt").unwrap();
    println!("solution: {}", solution(BufReader::new(input_file)));
}
