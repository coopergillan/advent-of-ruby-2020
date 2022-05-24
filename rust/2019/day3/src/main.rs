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

#[derive(Clone, Copy)]
struct Point {
    x: isize,
    y: isize,
}

impl Point {
    fn new(x: isize, y: isize) -> Self {
        Point { x, y }
    }

    fn manhattan_distance(&self) -> isize {
        self.x.abs() + self.y.abs()
    }
}

struct Wire {
    instructions: Vec<String>,
    current_position: Point,
    visited: Vec<Point>,
}

impl Wire {
    fn new(instructions: Vec<String>) -> Self {
        let current_position = Point::new(0, 0);
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
            let quantity = instruction_chars
                .as_str()
                .parse::<isize>()
                .expect("Could not parse integer");
            println!("Going {:?} numbers {:?}", quantity, direction);

            for _ in 0..quantity {
                match direction {
                    Some('R') => {
                        self.current_position.x += 1;
                        self.visited.push(self.current_position);
                    }
                    Some('U') => {
                        self.current_position.y += 1;
                        self.visited.push(self.current_position);
                    }
                    Some('L') => {
                        self.current_position.x -= 1;
                        self.visited.push(self.current_position);
                    }
                    Some('D') => {
                        self.current_position.y -= 1;
                        self.visited.push(self.current_position);
                    }
                    _ => println!("Found other direction: {}", direction.unwrap()),
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

    #[test]
    fn test_manhattan_distance() {
        let point1 = Point::new(5, 3);
        assert_eq!(point1.manhattan_distance(), 8);

        let mut point2 = Point::new(672, -12);
        assert_eq!(point2.manhattan_distance(), 684);
    }

    #[test]
    fn test_find_overlapping_points() {
        let wire1 = Wire::new(vec![
            "R75".to_string(),
            "D30".to_string(),
            "R83".to_string(),
            "U83".to_string(),
            "L12".to_string(),
            "D49".to_string(),
            "R71".to_string(),
            "U7".to_string(),
            "L72".to_string(),
        ]);

        let wire2 = Wire::new(vec![
            "U62".to_string(),
            "R66".to_string(),
            "U55".to_string(),
            "R34".to_string(),
            "D71".to_string(),
            "R55".to_string(),
            "D58".to_string(),
            "R83".to_string(),
        ]);

        wire1.map_path();
        wire2.map_path();

        let matched = wire1.contains(wire2);
        assert_eq!(
            matched,
            5,
        );
    }

    #[test]
    #[ignore]
    fn test_part1() {
        let test_part1 = part1(INPUT_FILE_NAME);
        assert_eq!(test_part1, 12);
    }
}
