use std::fs::File;
use std::io::{BufReader, BufRead};

fn play(line: &str) -> i32 {
    let result_score = match line {
        "A X" | "B Y" | "C Z" => 3,
        "A Y" | "B Z" | "C X" => 6,
        "A Z" | "B X" | "C Y" => 0,
        _ => panic!("unrecognized play of two hands"),
    };
    let hand_score = match line.as_bytes() {
        [_, b' ', b'X'] => 1, 
        [_, b' ', b'Y'] => 2, 
        [_, b' ', b'Z'] => 3, 
        _ => panic!("unrecognized hand"),
    };
    println!("{}: play {}, hand {}", line, result_score, hand_score);
    result_score + hand_score
}

fn solution(reader: BufReader<File>) -> i32 {
    let mut sum = 0;
    for line_result in reader.lines() {
        sum = sum + play(&line_result.unwrap());
    }
    sum
}

/// A rock
/// B paper
/// C scissors
///
/// X response rock
/// Y response paper
/// Z response scissors
fn main() {
    let test_file = File::open("./02/test").unwrap();
    assert_eq!(solution(BufReader::new(test_file)), 15);

    let input_file = File::open("./02/input.txt").unwrap();
    println!("solution: {}", solution(BufReader::new(input_file))); // expected 11475
}

