use std::fs::File;
use std::io::{BufRead, BufReader};

fn solution(input: BufReader<File>) -> u64 {
    let mut res = 0;
    let mut dir_stack: Vec<u64> = Vec::new();

    for line_result in input.lines() {
        match line_result
            .expect("failed to parse string")
            .split_once(" ")
            .expect("failed to split line")
        {
            ("$", "ls") => { /* do nothing */ }
            ("dir", _dir_name) => { /* do nothing */ }
            ("$", cmd) => {
                match cmd.split_once(" ") {
                    Some(("cd", "/")) => {
                        // asume `$ cd /` called only once
                        /* do nothing */
                    }
                    Some(("cd", "..")) => {
                        let current_size = dir_stack
                            .pop()
                            .expect("failed to retreive the current dir size");
                        if let Some(previous_size) = dir_stack.last_mut() {
                            *previous_size += current_size;
                        }
                        if current_size <= 100_000 {
                            res += current_size;
                        }
                    }
                    Some(("cd", _dir_name)) => {
                        dir_stack.push(0);
                    }
                    Some(val) => panic!("unhandled command: {:?}", val),
                    None => panic!("failed to parse command"),
                }
            }
            (raw_num, _file_name) => {
                if let Some(current) = dir_stack.last_mut() {
                    let file_size = raw_num.parse::<u64>().expect("failed to parse file line");
                    *current += file_size;
                }
            }
        }
    }

    for dir_size in dir_stack {
        if dir_size <= 100_000 {
            res += dir_size;
        }
    }

    res
}

fn main() {
    let test_file = File::open("./07/test.txt").unwrap();
    assert_eq!(solution(BufReader::new(test_file)), 95437);

    let input_file = File::open("./07/input.txt").unwrap();
    println!("solution: {}", solution(BufReader::new(input_file))); // answer 1513699
}
