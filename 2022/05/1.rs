use std::fs;
use std::str;

type Stacks = Vec<Vec<char>>;

#[derive(Debug)]
struct Move {
    items: usize,
    from: usize,
    to: usize,
}

impl Move {
    fn from_idx(&self) -> usize {
        self.from - 1
    }

    fn to_idx(&self) -> usize {
        self.to - 1
    }
}

fn parse(input: String) -> (Stacks, Vec<Move>) {
    let mut moves = Vec::new();
    let parts = input.split("\n\n").collect::<Vec<&str>>();
    if parts.len() != 2 {
        panic!("failed to split input into stacks and moves parts");
    }

    let mut stack_lines = parts[0].lines().rev();
    let num_stacks = stack_lines
        .next()
        .expect("empty stack part")
        .chars()
        .filter(|c| !c.is_whitespace())
        .count();
    let mut stacks: Stacks = vec![Vec::new(); num_stacks];
    for stack_line in stack_lines {
        for (char_idx, c) in stack_line.chars().enumerate() {
            if c.is_alphabetic() {
                //     [D]
                // [N] [C]
                // [Z] [M] [P]
                //  1   2   3
                // 0123456789 char_idx
                //  0   1   2 stack_idx = (char_id / 4)
                stacks[(char_idx / 4)].push(c);
            }
        }
    }

    for move_line in parts[1].lines() {
        let move_part = move_line.split(" ").collect::<Vec<&str>>();
        moves.push(Move {
            items: move_part[1]
                .parse()
                .expect("failed to parse move item part"),
            from: move_part[3]
                .parse()
                .expect("failed to parse move from part"),
            to: move_part[5].parse().expect("failed to parse move to part"),
        });
    }

    (stacks, moves)
}

fn solution(input: (Stacks, Vec<Move>)) -> String {
    let mut res_stacks = input.0.clone();
    for mv in input.1 {
        for _ in 0..mv.items {
            let item = res_stacks[mv.from_idx()].pop().expect("item");
            res_stacks[mv.to_idx()].push(item);
        }
    }
    res_stacks.iter().map(|stack| stack.last().unwrap()).collect::<String>()
}

fn main() {
    assert_eq!(
        solution(parse(
            fs::read_to_string("./05/test.txt").expect("failed to read file test")
        )),
        "CMZ"
    );

    println!(
        "solution: {}",
        solution(parse(
            fs::read_to_string("./05/input.txt").expect("failed to read file input")
        ))
    ); // solution CWMTGHBDW
}
