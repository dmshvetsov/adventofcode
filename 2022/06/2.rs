use std::fs;
use std::collections::HashSet;

const MSG_BYTE_SIZE: usize = 14;

fn is_unique_seq(seq: &[u8]) -> bool {
    let mut set = HashSet::new();
    for bt in seq {
        set.insert(bt);
    }
    set.len() == seq.len()
}

fn parse(input: String) -> String {
    input
}

fn solution(input: String) -> usize {
    let bytes = input.as_bytes();
    let length = bytes.len();
    let mut idx = 0;
    loop {
        if is_unique_seq(&bytes[idx..idx + MSG_BYTE_SIZE]) {
            return idx + MSG_BYTE_SIZE;
        }
        idx += 1;
        if idx == length {
            break;
        }
    }
    panic!("solution not found");
}

fn main() {
    assert_eq!(
        solution(parse("mjqjpqmgbljsphdztnvjfqwrcgsmlb".to_string())),
        19
    );
    assert_eq!(
        solution(parse("bvwbjplbgvbhsrlpgdmjqwftvncz".to_string())),
        23
    );
    assert_eq!(
        solution(parse("nppdvjthqldpwncqszvftbrmjlhg".to_string())),
        23
    );
    assert_eq!(
        solution(parse("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg".to_string())),
        29
    );
    assert_eq!(
        solution(parse("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw".to_string())),
        26
    );

    println!(
        "solution: {}",
        solution(parse(
            fs::read_to_string("./06/input.txt").expect("failed to read file input")
        ))
    ); // solution 3708
}
