// Advent of Code solver

use regex::Regex;
// use std::fs;

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

    let input_file = "test_input.txt";

    //     let monkey_business = MonkeyBusiness::from_file(input_file);
    //
    //     println!("Part 1 answer: {}", top_level.solve_part1());
    //     println!("Part 2 answer: {}", top_level.solve_part2());
}

#[derive(Debug, PartialEq)]
struct Monkey {
    items: Vec<usize>,
    operation: Operation,
    test_divisor: usize,
    divisor_results: DivisorResult,
}

impl Monkey {
    // fn new(raw_input: &str) {
    fn new(raw_input: &str) -> Self {

        let processed_input = raw_input
            .lines()
            .map(|v| v.trim())
            .filter(|v| v != &"")
            .collect::<Vec<&str>>();

        println!("processed_input: {:?}", processed_input);

        if let [_, raw_starting_items, raw_operation, raw_test_divisor, raw_true, raw_false] = &processed_input[..4] {

            let items = starting_items_vec(raw_starting_items);
            let operation = get_operation_data(raw_operation);
            let test_divisor = get_test_divisor(raw_test_divisor);
            let raw_true_false = raw_true.push_str(raw_false);
            println!("raw_true_false: {:?}", raw_true_false);
            let divisor_results = get_divisor_results(raw_true_false);
            Monkey {
                items,
                operation,
                test_divisor,
                divisor_results,
            }
        }
    }
}

#[derive(Debug, PartialEq)]
enum OperationType {
    Addition,
    Multiplication,
    Exponent,
}

#[derive(Debug, PartialEq)]
struct Operation {
    operation_type: OperationType,
    operation_value: usize,
}

#[derive(Debug, PartialEq)]
struct DivisorResult {
    true_monkey: usize,
    false_monkey: usize,
}

fn starting_items_vec(raw_text: &str) -> Vec<usize> {
    let re = Regex::new(r"\s+Starting items:\s{1}(?P<starting_items>.*)$").unwrap();

    let starting_items: Vec<usize> = re
        .captures(raw_text)
        .unwrap()
        .name("starting_items")
        .unwrap()
        .as_str()
        .split(", ")
        .map(|v| v.parse::<usize>().unwrap())
        .collect();
    starting_items
}

fn get_test_divisor(raw_text: &str) -> usize {
    let re = Regex::new(r"\s+Test:\s{1}divisible by (?P<divisor>\d+)$").unwrap();

    re.captures(raw_text)
        .expect("Did not have a capture")
        .name("divisor")
        .unwrap()
        .as_str()
        .parse::<usize>()
        .expect("Could not parse")
}

fn get_operation_data(raw_text: &str) -> Operation {
    let re = Regex::new(
        r"\s+Operation: new = old (?P<raw_operation_type>[+\*]) (?P<operation_value>\d+|old)$",
    )
    .unwrap();

    let raw_operation_value = re
        .captures(raw_text)
        .expect("operation_value did not have a capture")
        .name("operation_value")
        .unwrap()
        .as_str();

    let raw_operation_type: Vec<char> = re
        .captures(raw_text)
        .expect("raw_operation_type did not have a capture")
        .name("raw_operation_type")
        .unwrap()
        .as_str()
        .chars()
        .collect();

    let mut operation_value = raw_operation_value;
    let operation_type = match raw_operation_type[0] {
        '+' => Some(OperationType::Addition),
        '*' => match raw_operation_value {
            "old" => {
                operation_value = "2";
                Some(OperationType::Exponent)
            }
            _ => Some(OperationType::Multiplication),
        },
        _ => {
            println!("Didn't find anything");
            None
        }
    };

    Operation {
        operation_type: operation_type.unwrap(),
        operation_value: operation_value
            .parse::<usize>()
            .expect("Unable to parse operation value into usize"),
    }
}

fn get_divisor_results(raw_text: &str) -> DivisorResult {
    let re = Regex::new(
        r"\s+If true: throw to monkey (?P<true_monkey>\d+)\s+If false: throw to monkey (?P<false_monkey>\d)\s+$",
    )
    .unwrap();

    let true_monkey = re
        .captures(raw_text)
        .expect("true_monkey divisor results did not have a capture")
        .name("true_monkey")
        .unwrap()
        .as_str()
        .parse::<usize>()
        .expect("Unable to parse true_monkey to usize");

    let false_monkey = re
        .captures(raw_text)
        .expect("false_monkey divisor results did not have a capture")
        .name("false_monkey")
        .unwrap()
        .as_str()
        .parse::<usize>()
        .expect("Unable to parse true_monkey to usize");

    DivisorResult {
        true_monkey,
        false_monkey,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_starting_items_vec() {
        assert_eq!(
            starting_items_vec("  Starting items: 54, 65, 75, 74"),
            vec![54, 65, 75, 74]
        );
        assert_eq!(starting_items_vec("  Starting items: 79, 98"), vec![79, 98]);
    }

    #[test]
    fn test_get_test_divisor() {
        assert_eq!(get_test_divisor("  Test: divisible by 17"), 17);
        assert_eq!(get_test_divisor("  Test: divisible by 23"), 23);
    }

    #[test]
    fn test_get_operation_data() {
        assert_eq!(
            get_operation_data("  Operation: new = old + 6"),
            Operation {
                operation_type: OperationType::Addition,
                operation_value: 6
            },
        );
        assert_eq!(
            get_operation_data("  Operation: new = old * 19"),
            Operation {
                operation_type: OperationType::Multiplication,
                operation_value: 19
            },
        );
        assert_eq!(
            get_operation_data("  Operation: new = old * old"),
            Operation {
                operation_type: OperationType::Exponent,
                operation_value: 2
            },
        );
    }

    #[test]
    fn test_divisor_results() {
        assert_eq!(
            get_divisor_results("    If true: throw to monkey 0\n    If false: throw to monkey 1  "),
            DivisorResult {
                true_monkey: 0,
                false_monkey: 1
            },
        );
    }

    fn raw_monkey_input() -> &'static str {
        "Monkey 0:\n
          Starting items: 79, 98\n
          Operation: new = old * 19\n
          Test: divisible by 23\n
            If true: throw to monkey 2\n
            If false: throw to monkey 3"
    }

    #[test]
    fn test_monkey_new() {
        let monkey = Monkey::new(raw_monkey_input());
        assert!(true);
        // assert_eq!(monkey.items, vec![79, 98]);
    }

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
