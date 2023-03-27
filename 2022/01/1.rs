use std::fs;
use std::cmp;

/// return the biggest sum of numbers in blocks of lines separated by a blank line
fn solution(input: String) -> i32 {
    const LINE_BREAK: &str = "";
    let (res, _) = input.split("\n").fold((0, 0), |acc, line_item| {
        if line_item == LINE_BREAK {
            (acc.0, 0)
        } else {
            let calories = line_item.parse::<i32>().unwrap_or(0);
            (cmp::max(acc.0, acc.1 + calories), acc.1 + calories)
        }
    });
    res
}

fn main() {
    let test = fs::read_to_string("./01/test")
        .expect("Should have been able to read the 01/input file");
    let res_test = solution(test);
    assert!(res_test == 24_000, "got {} expected 24000", res_test);

    let input = fs::read_to_string("./01/input")
        .expect("Should have been able to read the 01/input file");
    let res1 = solution(input);
    println!("01/1 solution: {res1}"); // expected 67016
}
