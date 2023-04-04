use std::fs::File;
use std::io::{BufRead, BufReader};
use std::ops::Range;

fn parse(line: String) -> Vec<Range<u32>> {
    line.split(',')
        .map(|line_part| match line_part.find('-') {
            Some(idx) => (&line_part[..idx], &line_part[(idx + 1)..]),
            None => panic!("failed to parse line"),
        })
        .map(|(l_part, r_part)| Range {
            start: l_part.parse().expect("failed to parse string to integer"),
            end: r_part.parse().expect("failted to parse string to integer"),
        })
        .collect()
}

fn any_intersects(ranges: Vec<Range<u32>>) -> bool {
    for (idx, range) in ranges.iter().enumerate() {
        match ranges.get(idx + 1) {
            Some(other) => {
                if (range.start <= other.start && range.end >= other.end)
                || (range.start >= other.start && range.end <= other.end)
            {
                return true;
            }
            }
            _ => { /* do nothing */ }
        }
    }
    false
}

fn solution(reader: BufReader<File>) -> i32 {
    let mut sum = 0;
    for line_result in reader.lines() {
        match line_result {
            Ok(line) => {
                if any_intersects(parse(line)) {
                    sum += 1
                }
            }
            Err(_) => { /* do nothing */ }
        }
    }
    sum
}

fn main() {
    let test_file = File::open("./04/test.txt").unwrap();
    assert_eq!(solution(BufReader::new(test_file)), 2);

    let input_file = File::open("./04/input.txt").unwrap();
    println!("solution: {}", solution(BufReader::new(input_file))); // answer 511
}
