use std::fs;

fn parse(input: String) -> String {
    input
}

fn solution(input: String) -> usize {
    let bytes = input.as_bytes();
    let length = bytes.len();
    let mut idx = 0;
    loop {
        let chr = bytes[idx];
        if chr != bytes[idx + 1]
            && chr != bytes[idx + 2]
            && chr != bytes[idx + 3]
            && bytes[idx + 1] != bytes[idx + 2]
            && bytes[idx + 1] != bytes[idx + 3]
            && bytes[idx + 2] != bytes[idx + 3]
        {
            return idx + 4;
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
        7
    );
    assert_eq!(
        solution(parse("bvwbjplbgvbhsrlpgdmjqwftvncz".to_string())),
        5
    );
    assert_eq!(
        solution(parse("nppdvjthqldpwncqszvftbrmjlhg".to_string())),
        6
    );
    assert_eq!(
        solution(parse("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg".to_string())),
        10
    );
    assert_eq!(
        solution(parse("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw".to_string())),
        11
    );

    println!(
        "solution: {}",
        solution(parse(
            fs::read_to_string("./06/input.txt").expect("failed to read file input")
        ))
    ); // solution 1723
}
