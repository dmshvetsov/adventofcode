# --- Day 3: Rucksack Reorganization ---

One Elf has the important job of loading all of the rucksacks with supplies for the jungle journey. Unfortunately, that Elf didn't quite follow the packing instructions, and so a few items now need to be rearranged.

Each rucksack has two large compartments. All items of a given type are meant to go into exactly one of the two compartments. The Elf that did the packing failed to follow this rule for exactly one item type per rucksack.

The Elves have made a list of all of the items currently in each rucksack (your puzzle input), but they need your help finding the errors. Every item type is identified by a single lowercase or uppercase letter (that is, a and A refer to different types of items).

The list of items for each rucksack is given as characters all on a single line. A given rucksack always has the same number of items in each of its two compartments, so the first half of the characters represent items in the first compartment, while the second half of the characters represent items in the second compartment.

For example, suppose you have the following list of contents from six rucksacks:

```
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
```

- The first rucksack contains the items vJrwpWtwJgWrhcsFMMfFFhFp, which means its first compartment contains the items vJrwpWtwJgWr, while the second compartment contains the items hcsFMMfFFhFp. The only item type that appears in both compartments is lowercase p.
- The second rucksack's compartments contain jqHRNqRjqzjGDLGL and rsFMfFZSrLrFZsSL. The only item type that appears in both compartments is uppercase L.
- The third rucksack's compartments contain PmmdzqPrV and vPwwTWBwg; the only common item type is uppercase P.
- The fourth rucksack's compartments only share item type v.
- The fifth rucksack's compartments only share item type t.
- The sixth rucksack's compartments only share item type s.

To help prioritize item rearrangement, every item type can be converted to a priority:

- Lowercase item types a through z have priorities 1 through 26.
- Uppercase item types A through Z have priorities 27 through 52.
- In the above example, the priority of the item type that appears in both compartments of each rucksack is 16 (p), 38 (L), 42 (P), 22 (v), 20 (t), and 19 (s); the sum of these is 157.

Find the item type that appears in both compartments of each rucksack. What is the sum of the priorities of those item types?

## --- Part Two ---

As you finish identifying the misplaced items, the Elves come to you with another issue.

For safety, the Elves are divided into groups of three. Every Elf carries a badge that identifies their group. For efficiency, within each group of three Elves, the badge is the only item type carried by all three Elves. That is, if a group's badge is item type B, then all three Elves will have item type B somewhere in their rucksack, and at most two of the Elves will be carrying any other item type.

The problem is that someone forgot to put this year's updated authenticity sticker on the badges. All of the badges need to be pulled out of the rucksacks so the new authenticity stickers can be attached.

Additionally, nobody wrote down which item type corresponds to each group's badges. The only way to tell which item type is the right one is by finding the one item type that is common between all three Elves in each group.

Every set of three lines in your list corresponds to a single group, but each group can have a different badge item type. So, in the above example, the first group's rucksacks are the first three lines:

```
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
```

And the second group's rucksacks are the next three lines:

```
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
```

In the first group, the only item type that appears in all three rucksacks is lowercase r; this must be their badges. In the second group, their badge item type must be Z.

Priorities for these items must still be found to organize the sticker attachment efforts: here, they are 18 (r) for the first group and 52 (Z) for the second group. The sum of these is 70.

Find the item type that corresponds to the badges of each three-Elf group. What is the sum of the priorities of those item types?

## Other's solutions

```python
def part_1(data):
    result = 0
    for line in data:
        a, b = line[:len(line)//2], line[len(line)//2:]
        same = (set(a) & set(b)).pop()
        result += ascii_letters.index(same) + 1
    return result


def part_2(data):
    result = 0
    for i in range(0, len(data), 3):
        a, b, c = data[i:i+3]
        same = (set(a) & set(b) & set(c)).pop()
        result += ascii_letters.index(same) + 1
    return result
```

or 

```python
lines = open("inputs/3.txt").read().strip().split("\n")

def getVal(x):
    return ord(x) - ord('a') + 1 if x.islower() else ord(x) - ord('A') + 27

p1 = 0
for line in lines:
    m = len(line) // 2
    x, = set(line[:m]) & set(line[m:])
    p1 += getVal(x)

p2 = 0
for i in range(0, len(lines), 3):
    line1, line2, line3 = lines[i:i+3]
    x, = set(line1) & set(line2) & set(line3)
    p2 += getVal(x)
print("Part1", p1)
print("Part2", p2)
```

Some inspiring Rust solutions:

```Rust
// part 1
pub fn main() {
    println!(
        "{}",
        include_bytes!("../input.txt")
            .split(|b| *b == b'\n')
            .map(|l| l.split_at(l.len() / 2))
            .map(|(a, b)| b
                .iter()
                .filter(|b| a.contains(b))
                .map(|b| if *b >= b'a' {
                    (b - b'a') as i16 + 1
                } else {
                    (b - b'A') as i16 + 27
                })
                .next()
                .unwrap())
            .sum::<i16>(),
    );
}

// part 2
pub fn main() {
    println!(
        "{}",
        include_bytes!("../input.txt")
            .split(|b| *b == b'\n')
            .collect::<Vec<_>>()
            .chunks(3)
            .map(|set| set[0]
                .iter()
                .find(|b| set[1].contains(b) && set[2].contains(b))
                .unwrap())
            .map(|b| if *b >= b'a' {
                (b - b'a') as i16 + 1
            } else {
                (b - b'A') as i16 + 27
            })
            .sum::<i16>(),
    );
}
```

similar

```Rust
use itertools::Itertools;

fn value(c: u8) -> usize {
  match c {
    b'a'..=b'z' => c as usize - b'a' as usize + 1,
    b'A'..=b'Z' => c as usize - b'A' as usize + 27,
    _ => unreachable!(),
  }
}

fn same_chars(a: &[u8], b: &[u8]) -> Vec<u8> {
  a.iter().copied().filter(|c| b.contains(c)).collect()
}

#[aoc::main(03)]
fn main(input: &str) -> (usize, usize) {
  let lines = input.lines().map(str::as_bytes).collect::<Vec<_>>();
  let p1 = lines.iter()
    .map(|l| same_chars(&l[..l.len()/2], &l[l.len()/2..]))
    .map(|c| value(c[0]))
    .sum();
  let p2 = lines.iter()
    .tuples()
    .map(|(a,b,c)| same_chars(a, &same_chars(b, c)))
    .map(|c| value(c[0]))
    .sum();
  (p1, p2)
}
```

another one

```Rust
use itertools::Itertools;

fn compartment_to_bitmap(compartment: &str) -> u64 {
    compartment.chars().fold(0, |a, char| {
        a | (1
            << match char {
                'a'..='z' => char as u64 - 97,
                'A'..='Z' => char as u64 - 39,
                _ => unreachable!(),
            })
    })
}

fn main() {
    let input = include_str!("input.txt");

    let rucksacks: Vec<_> = input.lines().collect();

    let mut priority_sum = 0;

    for (compartment_a, compartment_b) in rucksacks.iter().map(|n| n.split_at(n.len() / 2)) {
        let compartment_a = compartment_to_bitmap(compartment_a);
        let compartment_b = compartment_to_bitmap(compartment_b);

        let duplicate = ((compartment_a & compartment_b) as f64).log2() as u64;

        priority_sum += duplicate + 1;
    }

    println!("Day 1: {priority_sum}");

    let mut priority_sum_2 = 0;

    for (rucksack_a, rucksack_b, rucksack_c) in rucksacks.iter().tuples() {
        let rucksack_a = compartment_to_bitmap(rucksack_a);
        let rucksack_b = compartment_to_bitmap(rucksack_b);
        let rucksack_c = compartment_to_bitmap(rucksack_c);

        let duplicate = ((rucksack_a & rucksack_b & rucksack_c) as f64).log2() as u64;

        priority_sum_2 += duplicate + 1;
    }

    println!("Day 2: {priority_sum_2}");
}
```
