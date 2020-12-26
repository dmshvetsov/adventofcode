use std::collections::HashMap;
use std::time;

// Van Eck Sequence

const COUNTER_START_VALUE: usize = 0;

fn solution(data: Vec<usize>, count_till: usize) -> usize {
    let s_time = time::SystemTime::now();

    let mut occurences: HashMap<usize, usize> = HashMap::new();
    for (idx, num) in data[..data.len() - 1].iter().enumerate() {
        occurences.insert(*num, idx + 1);
    }

    let mut turn: usize = data.len() - 1;
    let mut prev_num: usize = *data.last().unwrap();
    loop {
        turn += 1;

        let next_num = match occurences.get(&prev_num) {
            Some(prev_occ) => turn - prev_occ,
            None => COUNTER_START_VALUE,
        };

        occurences.insert(prev_num, turn);
        if turn == count_till {
            break;
        }
        prev_num = next_num;
    }

    println!("Spent using HashMap {:?}", s_time.elapsed().unwrap());
    prev_num
}

// fn read_input(file_path: &str) -> Vec<usize> {
//     std::fs::read_to_string(file_path)
//         .unwrap()
//         .lines()
//         .map(|line| line.parse::<usize>().unwrap())
//         .collect()
// }

fn main() {
    println!("Example: {}", solution(vec![0, 3, 6], 2020));
    println!("Part 1: {}", solution(vec![16, 12, 1, 0, 15, 7, 11], 2020));
    println!("Part 2: {}", solution(vec![16, 12, 1, 0, 15, 7, 11], 30_000_000));
}
