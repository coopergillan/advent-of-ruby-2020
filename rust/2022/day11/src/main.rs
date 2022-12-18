// Advent of Code solver

use std::fs;
use regex::Regex;

// #[derive(Debug, PartialEq)]
// struct MonkeyBusiness {
//     // For a graph type of problem use a vector of vectors
//     monkeys: Vec<Monkey>,
// }
//
// impl MonkeyBusiness {
//     // For one value per line use a vector of integers
//     // If negative numbers needed, change to usize
//     fn new(monkeys: Vec<Monkey>) -> Self {
//         MonkeyBusiness { monkeys }
//     }
//
//     fn from_file(file_path: &str) -> Self {
//         // For reading each line into an array
//         // let raw_content = fs::read_to_string(file_path).expect("Unable to read file");
//         //
//         // let processed_contents: Vec<Vec<usize>> = raw_content
//         //     .lines()
//         //     .map(|line| {
//         //         line.split(",")
//         //             .map(|v| v.parse::<usize>().expect("Unable to parse"))
//         //             .collect() // Inside Vec<usize> created here
//         //     })
//         //     .collect();
//         //
//         // println!(
//         //     "Creating struct with processed contents: {:?}",
//         //     processed_contents
//         // );
//         let processed_contents = Monkey::new(
//             // vec![5, 3], "old * old", "divisible by 13", 1, 3
//         );
//         Self::new(vec![processed_contents])
//     }
//
//     fn solve_part1() -> usize {
//         7
//     }
// }

fn main() {
    println!("Hello world");
    //     let input_file = "test_double_line_break_input.txt";
    //
    //     let monkey_business = MonkeyBusiness::from_file(input_file);
    //
    //     println!("Part 1 answer: {}", top_level.solve_part1());
    //     println!("Part 2 answer: {}", top_level.solve_part2());
}

#[derive(Debug, PartialEq)]
struct Monkey {
    items: Vec<usize>,
    operation: String,
    test_for_monkey: String,
    true_monkey: usize,
    false_monkey: usize,
}

impl Monkey {
    fn new(raw_starting_items: &str, raw_operation: &str, raw_test: &str, raw_true: &str) -> Self {
        let starting_items = starting_items_vec(raw_starting_items);
        let items = vec![];
        let operation = String::from("what is it?");
        let test_for_monkey = String::from("divisible by 23");
        let true_monkey = 2;
        let false_monkey = 4;
        Monkey {
            items,
            operation,
            test_for_monkey,
            true_monkey,
            false_monkey,
        }
    }
}

fn starting_items_vec(raw_input: &str) -> Vec<usize> {
    let re_pattern = r"\s+Starting items:\s{1}(?P<starting_items>.*)$";
    let re = Regex::new(re_pattern).unwrap();

    // let collected = ;

    let starting_items: Vec<usize> = re
        .captures(raw_input)
        .unwrap()
        .name("starting_items")
        .unwrap()
        .as_str()
        .split(", ")
        .map(|v| v.parse::<usize>().unwrap())
        .collect();
    starting_items
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_starting_items_vec() {
        let raw_input = "  Starting items: 54, 65, 75, 74";
        assert_eq!(starting_items_vec(raw_input), vec![54, 65, 75, 74]);
    }

    // #[test]
    // fn test_monkey_new() {
    //     let monkey = Monkey::new(
    //     "  Starting items: 54, 65, 75, 74",
    //     );
    //     assert_eq!(monkey.items, vec![4, 5]);
    // }

    // #[test]
    // #[ignore]
    // fn test_from_file_top_level_one_int_per_line() {
    //     let input_file = "test_input_one_int_per_line.txt";
    //     let top_level = TopLevelStructOneIntPerLine::from_file(input_file);
    //     assert_eq!(top_level.input_data, vec![5, 9, 13, 4])
    // }

    // #[test]
    // #[ignore]
    // fn test_from_file_top_level_multiple_ints_per_line() {
    //     let input_file = "test_input_multiple_ints_per_line.txt";
    //     let top_level = TopLevelStructMultipleIntsPerLine::from_file(input_file);
    //     println!("top_level_struct.input_data: {:?}", top_level.input_data);
    //     assert_eq!(
    //         top_level.input_data,
    //         vec![
    //             vec![5, 7, 13, 2],
    //             vec![9, 314, 2718, 17],
    //             vec![13, 8, 7, 4],
    //             vec![4, 22, 19, 33],
    //             vec![5, 20, 79, 13],
    //         ]
    //     )
    // }

    // #[test]
    // #[ignore]
    // fn test_from_file_top_level_double_line_breaks() {
    //     let input_file = "test_double_line_break_input.txt";
    //     let top_level = TopLevelStructDoubleLineBreak::from_file(input_file);
    //     println!("top_level_struct.input_data: {:?}", top_level.input_data);
    //     assert_eq!(
    //         top_level.input_data,
    //         vec![
    //             vec![1000, 2000, 3000],
    //             vec![4000],
    //             vec![5000, 6000],
    //             vec![7000, 8000, 9000],
    //             vec![10000],
    //         ]
    //     )
    // }

    // #[test]
    // #[ignore]
    // fn test_part1() {
    //     assert_eq!(5, 6);
    // }

    // #[test]
    // fn test_part2() {
    //     assert_eq!(22, 10);
    // }
}
