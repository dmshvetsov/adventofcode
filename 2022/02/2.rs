use std::fs::File;
use std::io::{BufReader, BufRead};

fn play(line: &str) -> i32 {
    let result_score = match line {
        "A X" | "B X" | "C X" => 0,
        "A Y" | "B Y" | "C Y" => 3,
        "A Z" | "B Z" | "C Z" => 6,
        _ => panic!("unrecognized play of two hands"),
    };
    let played_hand = match line.as_bytes() {
        [oponent_hand, b' ', b'Y'] => *oponent_hand, 
        [b'A', b' ', b'X'] => b'C', 
        [b'B', b' ', b'X'] => b'A', 
        [b'C', b' ', b'X'] => b'B', 
        [b'A', b' ', b'Z'] => b'B', 
        [b'B', b' ', b'Z'] => b'C', 
        [b'C', b' ', b'Z'] => b'A', 
        _ => panic!("unrecognized move"),
    };
    let hand_score = match played_hand {
        b'A' => 1,
        b'B' => 2,
        b'C' => 3,
        _ => panic!("unrecognized played hand"),
    };
    println!("{}: hand {}, play score {}, hand score {}", line, played_hand, result_score, hand_score);
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
/// X pick a hand to lose
/// Y pick a hand to draw
/// Z pick a hand to win
fn main() {
    let test_file = File::open("./02/test").unwrap();
    assert_eq!(solution(BufReader::new(test_file)), 12);

    let input_file = File::open("./02/input.txt").unwrap();
    println!("solution: {}", solution(BufReader::new(input_file))); // expected 16862
}

