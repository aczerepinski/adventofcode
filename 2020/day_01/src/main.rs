use std::io::{self, BufRead};
use std::fs::File;
use std::path::Path;

fn main() {
    let numbers = parse_input(String::from("./src/input.txt"));
    println!("part one: {}", part_one(&numbers));
    println!("part two: {}", part_two(&numbers))
}

fn part_one(numbers: &Vec<i32>) -> i32 {
    let (a, b) = find_pair_for_sum(numbers, 2020);
    a * b
}

fn part_two(numbers: &Vec<i32>) -> i32 {
    let (a, b, c) = find_trio_for_sum(numbers, 2020);
    a * b * c
}

#[test]
fn test_parse_input() {
    let filepath = String::from("./src/input.txt");
    let parsed = parse_input(filepath);
    assert!(parsed.len() > 10)
}


fn parse_input(path: String) -> Vec<i32> {
    let mut parsed = vec![];
    if let Ok(lines) = read_lines(path) {
        for line in lines {
            if let Ok(num) = line.unwrap().parse::<i32>() {
                parsed.push(num)
            }
        }
    }
    parsed
}

fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}

#[test]
fn test_find_pair_for_sum() {
    let numbers = vec![1721, 979, 366, 299, 675, 1456];
    let (a, b) = find_pair_for_sum(&numbers, 2020);
    assert_eq!(a + b, 2020)
}

#[test]
fn test_find_trio_for_sum() {
    let numbers = vec![1721, 979, 366, 299, 675, 1456];
    let (a, b, c) = find_trio_for_sum(&numbers, 2020);
    assert_eq!(a + b + c, 2020)
}

fn find_pair_for_sum(numbers: &Vec<i32>, sum: i32) -> (i32, i32) {
    let mut num_clone = numbers.to_vec();
    let mut optional = Some(num_clone.pop());
    while let Some(a) = optional {
        for b in &num_clone {
            if a.unwrap() + b == sum {
                return (a.unwrap(), *b)
            }
        }
        optional = Some(num_clone.pop());
    }
    (0,0)
}

fn find_trio_for_sum(numbers: &Vec<i32>, sum: i32) -> (i32, i32, i32) {
    for a in numbers {
        for b in numbers {
            for c in numbers {
                if a + b + c == sum {
                    return (*a, *b, *c)
                }
            }
        }
    }
    (0,0,0)
}
