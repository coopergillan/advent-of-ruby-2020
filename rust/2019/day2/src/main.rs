// Day 2 - 1202 program alert

use std::fs;

// #[derive(Debug, PartialEq)]
// struct IntcodeReader {
//     raw_input: vec<usize>,
// }

#[derive(Debug)]
struct IntcodeInput {
    code_sequence: Vec<usize>,
}

#[derive(Debug, PartialEq)]
struct Intcode {
    op_code: usize,
    operand_positions: Vec<usize>,
    pos_to_write: usize,
}

impl Intcode {
    fn process_input(&self, all_input: &mut Vec<usize>) {
        // let mut value_and_location = vec![];

        if let [pos1, pos2] = &self.operand_positions[..] {
            match self.op_code {
                1 => {
                    let value = all_input[*pos1] + all_input[*pos2];
                    all_input[self.pos_to_write] = value;
                    // value_and_location.push(value);
                    // value_and_location.push(self.pos_to_write)
                }
                _ => println!("Couldn't find op_code"),
            };
        }

        // Now go write the computed value to the correct spot
        // value_and_locatio\vp
    }
}

fn read_input(file_path: &str) -> Vec<usize> {
    fs::read_to_string(file_path)
        .expect("Unable to read file")
        .replace("\n", "")
        .split(",")
        .map(|v| v.parse::<usize>().expect("Unable to parse"))
        .collect()
}

fn main() {
    let code_sequence = read_input("test_input.txt");
    let mut full_input = IntcodeInput { code_sequence };

    assert_eq!(full_input.code_sequence.len(), 12);

    let chunkable = full_input.code_sequence.clone();
    for intcode_raw in chunkable.chunks(4) {
    // for intcode_raw in full_input.code_sequence.chunks(4) {
        let intcode = Intcode {
            op_code: intcode_raw[0],
            operand_positions: vec![intcode_raw[1],intcode_raw[2]],
            pos_to_write: intcode_raw[3],
        };
        intcode.process_input(&mut full_input.code_sequence);
    }
}

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
        let mut all_input = vec![1, 2, 5, 6, 7, 7];

        let intcode1 = Intcode {
            op_code: 1,
            operand_positions: vec![4, 1],
            pos_to_write: 5,
        };
        intcode1.process_input(&mut all_input);

        assert_eq!(vec![1, 2, 5, 6, 7, 9], all_input);
    }

    #[test]
    #[ignore]
    fn test_process_intcode_multiply_input() {
        let mut all_input = vec![1, 2, 5, 6, 7, 7];
        let intcode1 = Intcode {
            op_code: 2,
            operand_positions: vec![3, 11],
            pos_to_write: 0,
        };

        intcode1.process_input(&mut all_input);

        assert_eq!(vec![3, 1, 4], all_input);
    }
}
