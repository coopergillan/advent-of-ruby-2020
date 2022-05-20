// Day 2 - 1202 program alert

use std::fs;

const INSTRUCTION_SIZE: usize = 4;

fn read_input_file(file_path: &str) -> Vec<usize> {
    fs::read_to_string(file_path)
        .expect("Unable to read file")
        .replace("\n", "")
        .split(",")
        .map(|v| v.parse::<usize>().expect("Unable to parse"))
        .collect()
}

struct Input {
    details: Vec<usize>,
}

impl Input {
    /// Read file contents in, then update noun and verb
    fn new(input_file_name: &str, noun: usize, verb: usize) -> Self {
        let mut details = read_input_file(input_file_name);
        details[1] = noun;
        details[2] = verb;

        Input { details }
    }

    fn process_instruction(&mut self, instruction: Instruction) {
        let value1 = self.details[instruction.param1];
        let value2 = self.details[instruction.param2];

        let value = match instruction.opcode {
            1 => value1 + value2,
            2 => value1 * value2,
            _ => {
                println!("Couldn't find opcode: {:?}\n", instruction.opcode);
                0
            }
        };
        if value > 0 {
            self.details[instruction.param3] = value;
        };
    }

    fn size(&self) -> usize {
        self.details.len()
    }
}

struct Instruction {
    opcode: usize,
    param1: usize,
    param2: usize,
    param3: usize,
}

impl Instruction {
    fn new(opcode: usize, param1: usize, param2: usize, param3: usize) -> Self {
        Instruction {
            opcode,
            param1,
            param2,
            param3,
        }
    }
}

fn part1() -> usize {
    let noun = 12;
    let verb = 2;
    let mut input = Input::new("input.txt", noun, verb);

    // Iterate through the values four at a time using indexes
    for intcode_raw in (0..input.size()).step_by(INSTRUCTION_SIZE) {
        let instruction_end = intcode_raw + INSTRUCTION_SIZE;

        if let [opcode, param1, param2, param3] = input.details[intcode_raw..instruction_end] {
            let instruction = Instruction::new(opcode, param1, param2, param3);
            match instruction.opcode {
                99 => break,
                _ => input.process_instruction(instruction),
            }
        }
    }
    input.details[0]
}

fn main() {
    let part1 = part1();
    println!("Part one answer: {}", part1);
}

#[cfg(test)]
mod tests {
    use super::*;

    const INPUT_FILE_NAME: &str = "test_input.txt";
    const NOUN: usize = 11;
    const VERB: usize = 3;

    fn input_for_testing() -> Input {
        Input::new(INPUT_FILE_NAME, NOUN, VERB)
    }

    #[test]
    fn test_read_input_file() {
        assert_eq!(
            read_input_file(INPUT_FILE_NAME),
            vec![1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50],
        );
    }

    #[test]
    fn test_prepare_input() {
        let input = input_for_testing();
        assert_eq!(
            input.details,
            vec![1, 11, 3, 3, 2, 3, 11, 0, 99, 30, 40, 50],
        );
    }

    #[test]
    fn test_process_instruction() {
        let mut input = input_for_testing();
        let instruction = Instruction::new(1, 11, 3, 3);
        input.process_instruction(instruction);

        assert_eq!(
            input.details,
            vec![1, 11, 3, 53, 2, 3, 11, 0, 99, 30, 40, 50],
        );
    }
}
