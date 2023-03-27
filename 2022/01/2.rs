use std::fs;

/// return top 3 sum of numbers in blocks of lines separated by a blank line
fn solution(input: String) -> i32 {
    const LINE_BREAK: &str = "";
    let mut res = (0, 0, 0);
    let mut acc = 0;
    for line_item in input.split("\n") {
        if line_item == LINE_BREAK {
            if res.0 < acc {
                res = (acc, res.0, res.1);
            } else if res.1 < acc {
                res = (res.0, acc, res.1);
            } else if res.2 < acc {
                res = (res.0, res.1, acc);
            }
            acc = 0;
        } else {
            let line_num = line_item.parse::<i32>().unwrap_or(0);
            acc = acc + line_num;
        }
    };
    res.0 + res.1 + res.2
}

fn main() {
    let test = fs::read_to_string("./01/test")
        .expect("Should have been able to read the 01/input file");
    let res_test = solution(test);
    assert!(res_test == 45_000, "got {} expected 24000", res_test);

    let input = fs::read_to_string("./01/input")
        .expect("Should have been able to read the 01/input file");
    let res1 = solution(input);
    println!("01/1 solution: {res1}"); // expected 200116
}
