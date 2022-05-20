// Day 2 - 1202 program alert

use std::fs;

const INSTRUCTION_SIZE: usize = 4;

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

struct Input {
    input_file: String,
    noun: usize,
    verb: usize,
}

impl Input {
    fn new(input_file_name: &str, noun: usize, verb: usize) -> Self {
        let input_file = input_file_name.to_string();

        Input { input_file, noun, verb }
    }

    fn prepare(&self) -> Vec<usize> {
        let mut raw_input = read_input_file(&self.input_file);
        raw_input[1] = self.noun;
        raw_input[2] = self.verb;
        raw_input
    }
}

fn read_input_file(file_path: &str) -> Vec<usize> {
    fs::read_to_string(file_path)
        .expect("Unable to read file")
        .replace("\n", "")
        .split(",")
        .map(|v| v.parse::<usize>().expect("Unable to parse"))
        .collect()
}

fn main() {
    let noun = 12;
    let verb = 2;
    let raw_input = Input::new("input.txt", noun, verb);
    let mut full_input = raw_input.prepare(); // code_sequence.clone();

    // Iterate through the values four at a time using indexes
    let input_size = full_input.len();
    for intcode_raw in (0..input_size).step_by(INSTRUCTION_SIZE) {
        let instruction_end = intcode_raw + INSTRUCTION_SIZE;

        if let [opcode, param1, param2, param3] = full_input[intcode_raw..instruction_end] {
            let value1 = full_input[param1];
            let value2 = full_input[param2];

            let value = match opcode {
                1 => value1 + value2,
                2 => value1 * value2,
                99 => break,
                _ => { println!("Couldn't find opcode: {:?}\n", opcode); 0 },
            };
            if value > 0 {
                full_input[param3] = value;
            };
        }
    }
    println!("Finished iterating - zeroth element of full_input: {:?}", full_input[0]);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_read_input_file() {
        assert_eq!(
            read_input_file("test_input.txt"),
            vec![1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50],
        );
    }

    #[test]
    fn test_prepare_input() {
        let noun = 12;
        let verb = 2;
        let input = Input::new("test_input.txt", noun, verb);

        assert_eq!(
            input.prepare(),
            vec![1, 12, 2, 3, 2, 3, 11, 0, 99, 30, 40, 50],
        );
    }
}
