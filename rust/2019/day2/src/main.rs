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

fn read_input(file_path: &str) -> Vec<usize> {
    fs::read_to_string(file_path)
        .expect("Unable to read file")
        .replace("\n", "")
        .split(",")
        .map(|v| v.parse::<usize>().expect("Unable to parse"))
        .collect()
}

fn main() {
    // let code_sequence = read_input("test_input.txt");
    let code_sequence = read_input("input.txt");
    println!("code_sequence: {:?}", code_sequence);
    let mut full_input = code_sequence.clone();
    full_input[1] = 12;
    full_input[2] = 2;

    let input_size = full_input.len();
    // assert_eq!(input_size, 12);

    // Iterate through the values four at a time using indexes
    for intcode_raw in (0..input_size).step_by(INSTRUCTION_SIZE) {
        println!("Working with full_input: {:?}", full_input);

        let opcode = code_sequence[intcode_raw];
        println!("opcode: {:?}", opcode);

        let first_input = code_sequence[intcode_raw + 1];
        println!("first_input: {:?}", first_input);

        let second_input = code_sequence[intcode_raw + 2];
        println!("second_input: {:?}", second_input);

        let write_position = code_sequence[intcode_raw + 3];
        println!("write_position: {:?}", write_position);

        match opcode {
            1 => {
                println!("Got opcode 1 so adding");
                let value = full_input[first_input] + full_input[second_input];
                println!("value from adding: {:?}", value);

                // .....okay Rust, can we do this???? Write value to the position
                full_input[write_position] = value;
                println!("Wrote value {:?} to write_postion {:?}\n", value, write_position);
            },
            2 => {
                println!("Got opcode 1 so adding");
                let value1 = full_input[first_input];
                println!("value1: {:?}", value1);

                let value2 = full_input[second_input];
                println!("value2: {:?}", value2);

                let final_value = value1 * value2;
                println!("final_value from multipying: {:?}", final_value);

                // .....okay Rust, can we do this???? Write value to the position
                full_input[write_position] = final_value;
                println!("Wrote final_value {:?} to write_postion {:?}\n", final_value, write_position);
            },
            99 => {
                println!("Got 99 - break");
                break
            },
            _ => println!("Couldn't find opcode\n"),
        };
    }
    println!("Finished iterating - full_input: {:?}", full_input);
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
