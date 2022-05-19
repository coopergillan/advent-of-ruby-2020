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
    println!("code_sequence: {:?}", code_sequence);
    let mut full_input = code_sequence.clone();
    // let mut full_input = IntcodeInput { code_sequence };

    let input_size = full_input.len();
    assert_eq!(input_size, 12);

    // Iterate through the values four at a time using indexes
    for intcode_raw in (0..input_size).step_by(4) {
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

    assert_eq!(full_input[3], 70);
    assert_eq!(full_input[0], 3500);
        // if intcode_raw[0] == 1 {
        //     let pos1 = int_code[1];
        //     let pos2 = int_code[2];
        //
        //     // Add the values together from those two positions
        //     let value = full_input[*pos1] + full_input[*pos2];
        //
        //     // Now write to the position specified
        //     full_input
        // match intcode_raw[0] {
        // }
        // }
        // let intcode_raw = four_step.expect("Unable to get values in slice");
        // println!("intcode_raw: {:?}" intcode_raw);

        // let intcode = Intcode {
        //     op_code: intcode_raw[0],
        //     operand_positions: vec![intcode_raw[1],intcode_raw[2]],
        //     pos_to_write: intcode_raw[3],
        // };
        // intcode.process_input(&mut full_input.code_sequence);
    // for intcode_raw in full_input.code_sequence.chunks(4) {
        // let intcode = Intcode {
        //     op_code: intcode_raw[0],
        //     operand_positions: vec![intcode_raw[1],intcode_raw[2]],
        //     pos_to_write: intcode_raw[3],
        // };
        // intcode.process_input(&mut full_input.code_sequence);
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
