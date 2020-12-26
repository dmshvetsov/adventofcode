// inspired by https://github.com/sijmn/aoc2020/blob/master/rust/src/day15.rs

use std::time;

// Van Eck Sequence

const COUNTER_START_VALUE: usize = 0;

fn solution(data: Vec<usize>, count_till: usize) -> usize {
    let s_time = time::SystemTime::now();

    // Trade memory for speed?
    // another option to try is to optimize HashMap for usage of
    // large amount of small int keys
    let mut occurences = vec![COUNTER_START_VALUE; count_till];
    let mut prev_num = data[0];
    for turn in 0..data.len() {
        occurences[prev_num] = turn; // without? + 1
        prev_num = data[turn];
    }

    for turn in data.len()..count_till {
        let next_num = occurences[prev_num];
        occurences[prev_num] = turn;
        prev_num = if next_num == 0 { 0 } else { turn - next_num };
    }

    println!("Spent using Vec {:?}", s_time.elapsed().unwrap());
    prev_num
}

fn main() {
    println!("0,3,6 == 436: {}", solution(vec![0, 3, 6], 2020));
    println!("Part 1: {}", solution(vec![16, 12, 1, 0, 15, 7, 11], 2020));
    println!("Part 2: {}", solution(vec![16, 12, 1, 0, 15, 7, 11], 30_000_000));
}
