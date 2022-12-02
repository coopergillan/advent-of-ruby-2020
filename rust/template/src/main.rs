// Advent of Code solver

use std::fs;

#[derive(Debug, PartialEq)]
struct TopLevelStructOneIntPerLine {
    // Accept the input as one attribute - use isize if negative numbers needed
    // For one value per line use a vector of integers
    input_data: Vec<usize>,
}

impl TopLevelStructOneIntPerLine {
    // For one value per line use a vector of integers
    fn new(input_data: Vec<usize>) -> Self {
        TopLevelStructOneIntPerLine { input_data }
    }

    fn from_file(file_path: &str) -> Self {
        // For reading each line into an array
        let raw_content = fs::read_to_string(file_path).expect("Unable to read file");

        // Process the content - for example change number in each line to an integer
        let raw_content_lines = raw_content.lines();
        let processed_content = raw_content_lines
            .map(|line| {
                line.to_string()
                    .parse::<usize>()
                    .expect("Unable to parse string to usize")
            })
            .collect();
        Self::new(processed_content)
    }
}

#[derive(Debug, PartialEq)]
struct TopLevelStructMultipleIntsPerLine {
    // For a graph type of problem use a vector of vectors
    input_data: Vec<Vec<usize>>,
}

impl TopLevelStructMultipleIntsPerLine {
    // For one value per line use a vector of integers
    // If negative numbers needed, change to usize
    fn new(input_data: Vec<Vec<usize>>) -> Self {
        TopLevelStructMultipleIntsPerLine { input_data }
    }

    fn from_file(file_path: &str) -> Self {
        // For reading each line into an array
        let raw_content = fs::read_to_string(file_path).expect("Unable to read file");

        let processed_contents: Vec<Vec<usize>> = raw_content
            .lines()
            .map(|line| {
                line.split(",")
                    .map(|v| v.parse::<usize>().expect("Unable to parse"))
                    .collect() // Inside Vec<usize> created here
            })
            .collect();

        println!("Creating struct with processed contents: {:?}", processed_contents);
        Self::new(processed_contents)
    }
}

// impl
// For graph type of problem use vector of vectors
// fn new(input_data: Vec<Vec<isize>>) -> Self {

// TODO: implement one where double line breaks distinguish other objects - elves from 2022 or Bingo boards from 2022
// For reading input with double line breaks that distinguish separate objects
// let raw_content_objects = raw_content.split("\n\n");

// fn read_input(file_path: &str) -> Vec<Vec<isize>> {
//     let raw_contents = fs::read_to_string(file_path).expect("Unable to read file");
//     let contents = raw_contents.lines();
//     contents
//         .map(|line| {
//             line.to_string()
//                 .parse::<i64>()
//                 .expect("Unable to parse string to integer")
//         })
//         .collect()
// }

fn main() {
    println!("Hello world");
    let input_file = "test_input_multiple_ints_per_line.txt";

    let top_level = TopLevelStructMultipleIntsPerLine::from_file(input_file);
    println!("Part 1 answer: {}", top_level.part1(input_file));
    // println!("Part 2 answer: {}", part2(input_file));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_from_file_top_level_one_int_per_line() {
        let input_file = "test_input_one_int_per_line.txt";
        let top_level = TopLevelStructOneIntPerLine::from_file(input_file);
        assert_eq!(top_level.input_data, vec![5, 9, 13, 4])
    }

    #[test]
    fn test_from_file_top_level_multiple_ints_per_line() {
        let input_file = "test_input_multiple_ints_per_line.txt";
        let top_level = TopLevelStructMultipleIntsPerLine::from_file(input_file);
        println!("top_level_struct.input_data: {:?}", top_level.input_data);
        assert_eq!(top_level.input_data, vec![
            vec![5, 7, 13, 2],
            vec![9,314,2718,17],
            vec![13,8,7,4],
            vec![4,22,19,33],
            vec![5,20,79,13],
        ])
    }

    // #[test]
    // fn test_read_input() {
    //     assert_eq!(read_input("test_input.txt"), vec![12, 14, 1969, 100756])
    // }
    //
    // #[test]
    // fn test_part1() {
    //     let input_file = "test_input.txt";
    //     assert_eq!(part1(input_file), 34241);
    // }
    //
    // #[test]
    // fn test_part2() {
    //     let input_file = "test_input.txt";
    //     assert_eq!(part2(input_file), 51316);
    // }
}

// fn part1(file_path: &str) -> i64 {
//     let input_masses = read_input(file_path);
//     let modules = collect_modules(input_masses);
//
//     modules
//         .iter()
//         .map(|module| module.calculate_fuel_part1())
//         .sum()
// }
//
// fn part2(file_path: &str) -> i64 {
//     let input_masses = read_input(file_path);
//     let modules = collect_modules(input_masses);
//
//     modules
//         .iter()
//         .map(|module| module.calculate_fuel_part2())
//         .sum()
// }
