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
    visited: Vec<[isize; 2]>,
}

impl Wire {
    fn new(instructions: Vec<String>) -> Self {
        let visited = vec![[0; 2]];
        Wire {
            instructions,
            visited,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    const INPUT_FILE_NAME: &str = "test_input.txt";

    #[test]
    fn test_wire_path() {
        let instructions = vec![
            "R8".to_string(),
            "U5".to_string(),
            "L5".to_string(),
            "D3".to_string(),
        ];

        let wire = Wire::new(instructions);
        assert_eq!(wire.instructions[1], "U5");
        assert_eq!(wire.visited[0], [0, 0]);
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
