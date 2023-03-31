use std::collections::HashSet;
use std::fs::File;
use std::io::{BufRead, BufReader};

// range a..=Z will will start with a char code (i32) 97 (a) to 122 (z) and continues from 65 (A) to 90 (Z)
// to put A over z add 58 to every char in A..=Z range
// and deduct CHARS_START from every char i32 value
const CHARS_START: i32 = 96;

fn find_char_in_grop(lines: Vec<String>) -> Option<char> {
    assert!(lines.len() > 0);

    let mut found: HashSet<char> = lines[0].chars().collect();
    for line in lines.iter().skip(1) {
        let mut new_found = HashSet::new();
        for c in line.chars() {
            if found.contains(&c) {
                new_found.insert(c);
            }
        }
        found = new_found;
    }

    found.into_iter().next()
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
        }
        None => 0,
    }
}

fn solution(reader: BufReader<File>) -> i32 {
    let mut sum = 0;
    let mut lines = reader.lines();
    loop {
        let chunk = lines.by_ref().take(3).collect::<Result<Vec<_>, _>>();
        match chunk {
            Ok(lines) => {
                if lines.is_empty() {
                    break;
                }
                sum += to_priority(find_char_in_grop(lines));
            }
            Err(e) => {
                eprintln!("error reading lines from the file: {}", e);
                std::process::exit(1);
            }
        }
    }
    sum
}

fn main() {
    let test_file = File::open("./03/test.txt").unwrap();
    assert_eq!(solution(BufReader::new(test_file)), 70);

    let input_file = File::open("./03/input.txt").unwrap();
    println!("solution: {}", solution(BufReader::new(input_file))); // expect 2545
}
