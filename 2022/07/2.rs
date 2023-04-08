use std::collections::HashMap;
use std::fs::File;
use std::io::{BufRead, BufReader};

const MAX: u64 = 70_000_000;
const REQUIRED: u64 = 30_000_000;

fn solution(input: BufReader<File>) -> u64 {
    let mut total = 0;
    let mut dir_stack: Vec<String> = Vec::new();
    let mut dir_sizes = HashMap::new();

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
                        dir_sizes.insert("/", 0u64);
                        // asume `$ cd /` called only once
                        /* do nothing */
                    }
                    Some(("cd", "..")) => {
                        if let Some(current_dir_name) = dir_stack.pop() {
                            if let (Some(parent_dir_name), Some(current_dir_size)) =
                                (dir_stack.last(), dir_sizes.get(&current_dir_name as &str))
                            {
                                dir_sizes
                                    .entry(parent_dir_name)
                                    .and_modify(|val| *val += current_dir_size);
                            }
                        }
                    }
                    Some(("cd", dir_name)) => {
                        dir_sizes.insert("/", 0u64);
                        dir_stack.push(dir_name.to_string());
                    }
                    Some(val) => panic!("unhandled command: {:?}", val),
                    None => panic!("failed to parse command"),
                }
            }
            (raw_num, _file_name) => {
                let file_size = raw_num.parse::<u64>().expect("failed to parse file line");
                total += file_size;
                if let Some(current_dir_name) = dir_stack.last() {
                    dir_sizes
                        .entry(current_dir_name)
                        .and_modify(|val| *val += file_size);
                }
            }
        }
    }

    *dir_sizes
        .values()
        .filter(|&&size| MAX - (total - size) >= REQUIRED)
        .min()
        .expect("solution not found")
}

fn main() {
    let test_file = File::open("./07/test.txt").unwrap();
    assert_eq!(solution(BufReader::new(test_file)), 24933642);

    let input_file = File::open("./07/input.txt").unwrap();
    println!("solution: {}", solution(BufReader::new(input_file))); // answer 1513699
}
