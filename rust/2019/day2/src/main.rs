// Day 2 - 1202 program alert

use std::fs;

// #[derive(Debug, PartialEq)]
// struct IntcodeReader {
//     raw_input: vec<usize>,
// }

#[derive(Debug, PartialEq)]
struct Intcode {
    op_code: usize,
    operand_positions: Vec<usize>,
    pos_to_write: usize,
}

impl Intcode {
    fn process_input(&self) -> Vec<usize> {
        let mut value_and_location = vec![];

        if let [val1, val2] = &self.operand_positions[..] {
            if self.op_code == 1 {
                let value = val1 + val2;
                value_and_location.push(value);
                value_and_location.push(self.pos_to_write)
            }
        }
        value_and_location
    }
}

fn read_input(file_path: &str) -> Vec<usize> {
    let raw = fs::read_to_string(file_path)
        .expect("Unable to read file")
        .replace("\n", "");

    let contents: Vec<usize> = raw
        .split(",")
        .map(|v| v.parse::<usize>().expect("Unable to parse"))
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

    #[test]
    fn test_process_intcode_sum_input() {
        let intcode1 = Intcode {
            op_code: 1,
            operand_positions: vec![10, 20],
            pos_to_write: 30,
        };

        assert_eq!(intcode1.process_input(), vec![30, 30],);
    }

    #[test]
    fn test_process_intcode_multiply_input() {
        let intcode1 = Intcode {
            op_code: 2,
            operand_positions: vec![3, 11],
            pos_to_write: 0,
        };

        assert_eq!(intcode1.process_input(), vec![30, 30],);
    }
}
