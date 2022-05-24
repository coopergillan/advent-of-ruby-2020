// Day 3 - crossing wires

use std::fs;

const INPUT_FILE: &str = "input.txt";

fn read_input_file(file_path: &str) -> Vec<usize> {
    fs::read_to_string(file_path)
        .expect("Unable to read file")
        .replace("\n", "")
        .split(",")
        .map(|v| v.parse::<usize>().expect("Unable to parse"))
        .collect()
}

fn part1(input_file_name: &str) -> usize {
    5
}

fn main() {
    let part1 = part1(INPUT_FILE);
    println!("Part one answer: {}", part1);
}

struct Wire {
    instructions: Vec<String>,
    current_position: [isize; 2],
    visited: Vec<[isize; 2]>,
}

impl Wire {
    fn new(instructions: Vec<String>) -> Self {
        let current_position = [0, 0];
        let visited = vec![];
        Wire {
            instructions,
            visited,
            current_position,
        }
    }

    fn map_path(&mut self) {
        for instruction in &self.instructions {
            let mut instruction_chars = instruction.chars();
            let direction = instruction_chars.next();
            let quantity = instruction_chars.as_str().parse::<isize>().expect("Could not parse integer");
            println!("Going {:?} numbers {:?}", quantity, direction);

            for _ in 0..quantity {
                match direction {
                    Some('R') => {
                        self.current_position[0] += 1;
                        self.visited.push(self.current_position);
                    },
                    Some('U') => {
                        self.current_position[1] += 1;
                        self.visited.push(self.current_position);
                    }
                    Some('L') => {
                        self.current_position[0] -= 1;
                        self.visited.push(self.current_position);
                    }
                    Some('D') => {
                        self.current_position[1] -= 1;
                        self.visited.push(self.current_position);
                    }
                    _ => println!("hi"),
                }
                // TODO: figure out how to not duplicate this push
                // self.visited.push(self.current_position);
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    const INPUT_FILE_NAME: &str = "test_input.txt";

    fn testing_wire() -> Wire {
        Wire::new(vec![
            "R8".to_string(),
            "U5".to_string(),
            "L5".to_string(),
            "D3".to_string(),
        ])
    }

    #[test]
    fn test_wire_path() {
        let wire = testing_wire();
        assert_eq!(wire.instructions[1], "U5");
        assert_eq!(wire.visited.len(), 0);
    }

    #[test]
    fn test_mapping_path() {
        let mut wire = testing_wire();
        wire.map_path();
        assert_eq!(wire.visited.len(), 21);
    }

    // #[test]
    // fn test_read_input_file() {
    //     assert_eq!(
    //         read_input_file(INPUT_FILE_NAME),
    //         vec![1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50],
    //     );
    // }

    #[test]
    #[ignore]
    fn test_part1() {
        let test_part1 = part1(INPUT_FILE_NAME);
        assert_eq!(test_part1, 12);
    }
}
