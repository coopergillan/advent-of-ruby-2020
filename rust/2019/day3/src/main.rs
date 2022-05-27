// Day 3 - crossing wires

use std::fs;

const INPUT_FILE: &str = "input.txt";

// fn read_input_file(file_path: &str) -> Vec<Vec<&str>> {
fn read_input_file(file_path: &str) -> Vec<Vec<String>> {
    let raw_contents = fs::read_to_string(file_path)
        .expect("Unable to read file");
    println!("raw_contents: {:?}", raw_contents);
    let contents = raw_contents.split_whitespace();
    // let contents = raw_contents.lines();
    println!("contents: {:?}", contents);

    // vec![vec![]]

    let mut parsed = vec![];
    for line in contents {
        let parsed_line: Vec<String> = line.split(",").map(|v| v.to_owned()).collect();
        parsed.push(parsed_line);
    }

    println!("Got parsed: {:?}", parsed);
    parsed
}

fn part1(input_file_name: &str) -> usize {
    5
}

fn main() {
    let part1 = part1(INPUT_FILE);
    println!("Part one answer: {}", part1);
}

// Find matches for wires that have mapped paths already
fn find_matches(left_wire: Wire, right_wire: Wire) -> Vec<Point> {
    let mut matches = vec![];
    for point in &left_wire.visited {
        if right_wire.visited.contains(&point) {
            matches.push(*point)
        }
    }
    println!("Got matches: {:?}", matches);
    matches
}

// Find matches for wires that have mapped paths already
fn find_shortest(matches: Vec<Point>) -> isize {
    let mut distances = vec![];
    for point in &matches {
        let distance = point.manhattan_distance();
        println!("Calculated distance {:?} for point {:?}", distance, point);
        distances.push(distance);
    }
    println!("Got distances: {:?}", distances);
    let shortest = distances.iter().min().expect("Unable to get minimum distance");
    println!("Got shortest: {:?}", shortest);
    *shortest
}

#[derive(Clone, Copy, Debug, PartialEq)]
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
            // println!("Going {:?} numbers {:?}", quantity, direction);

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

    fn testing_short_wire() -> Wire {
        Wire::new(vec![
            "R8".to_string(),
            "U5".to_string(),
            "L5".to_string(),
            "D3".to_string(),
        ])
    }

    fn test_wire1() -> Wire {
        Wire::new(vec![
            "R75".to_string(),
            "D30".to_string(),
            "R83".to_string(),
            "U83".to_string(),
            "L12".to_string(),
            "D49".to_string(),
            "R71".to_string(),
            "U7".to_string(),
            "L72".to_string(),
        ])
    }

    fn test_wire2() -> Wire {
        Wire::new(vec![
            "U62".to_string(),
            "R66".to_string(),
            "U55".to_string(),
            "R34".to_string(),
            "D71".to_string(),
            "R55".to_string(),
            "D58".to_string(),
            "R83".to_string(),
        ])
    }

    #[test]
    fn test_wire_path() {
        let wire = testing_short_wire();
        assert_eq!(wire.instructions[1], "U5");
        assert_eq!(wire.visited.len(), 0);
    }

    #[test]
    fn test_mapping_path() {
        let mut wire = testing_short_wire();
        wire.map_path();
        assert_eq!(wire.visited.len(), 21);
    }

    #[test]
    fn test_manhattan_distance() {
        let point1 = Point::new(5, 3);
        assert_eq!(point1.manhattan_distance(), 8);

        let point2 = Point::new(672, -12);
        assert_eq!(point2.manhattan_distance(), 684);
    }

    #[test]
    fn test_find_overlapping_points() {
        let mut wire1 = test_wire1();
        let mut wire2 = test_wire2();

        wire1.map_path();
        wire2.map_path();

        let matched = find_matches(wire1, wire2);

        assert_eq!(matched.len(), 4);
    }

    #[test]
    fn test_find_shortest() {
        let points = vec![
            Point::new(5, 8),
            Point::new(17, -5),
            Point::new(-5, 2),
            Point::new(-8, -1),
        ];
        let shortest = find_shortest(points);
        assert_eq!(shortest, 7);
    }

    #[test]
    fn test_read_input() {
        let test_input = read_input_file("test_input1.txt");
        println!("test_input: {:?}", test_input);
        assert_eq!(test_input.len(), 2);
    }

    #[test]
    #[ignore]
    fn test_part1() {
        let test_part1 = part1("test_input1.txt");
        assert_eq!(test_part1, 159);
    }
}
