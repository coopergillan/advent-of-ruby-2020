// Day 2 - 1202 program alert

use std::fs;

// #[derive(Debug, PartialEq)]
// struct IntcodeReader {
//     raw_input: vec<u32>
// }

fn read_input(file_path: &str) -> Vec<u32> {
    let raw = fs::read_to_string(file_path)
        .expect("Unable to read file")
        .replace("\n", "");

    let contents: Vec<u32> = raw
        .split(",")
        .map(|v| v.parse::<u32>().expect("Unable to parse"))
        .collect();
    contents
}

fn main() {}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_read_input() {
        assert_eq!(
            read_input("test_input.txt"),
            vec![1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50],
        );
    }
}
