// Advent of Code solver

use regex::Regex;
use std::collections::HashMap;
use std::fs;

const PART1_ROUNDS: usize = 20;

#[derive(Debug, PartialEq)]
struct MonkeyBusiness {
    // For a graph type of problem use a vector of vectors
    monkeys: Vec<Monkey>,
}

impl MonkeyBusiness {
    fn from_file(file_path: &str) -> Self {
        // For reading each line into an array
        let raw_content = fs::read_to_string(file_path).expect("Unable to read file");

        let processed_contents: Vec<Monkey> = raw_content
            .split("\n\n")
            .map(|raw_monkey| Monkey::new(raw_monkey))
            .collect();

        Self {
            monkeys: processed_contents,
        }
    }

    fn play_round(&mut self) {
        let total_monkey_count = self.monkeys.len();
        for monkey_number in 0..total_monkey_count {
            println!("Processing monkey number {}", monkey_number);
            // Make a copy of the monkey being checked
            let checked_monkey = &mut self.monkeys[monkey_number];
            println!("checked_monkey {:?}", checked_monkey);

            // Start assembling which items will go to which monkeys
            let mut todo_list: HashMap<usize, Vec<usize>> = HashMap::new();
            for k in 0..total_monkey_count {
                todo_list.insert(k, Vec::new());
            }

            // Go through each item for each monkey
            for _ in 0..checked_monkey.items.len() {
                // After finding out which monkey it should be thrown to, append worry_level to that monkey's items and remove from checked_monkey
                let item_to_check = checked_monkey.items.remove(0);
                let (dest_monkey, worry_level) = inspect_item(&checked_monkey, item_to_check);
                checked_monkey.checked_items_count += 1;
                todo_list.get_mut(&dest_monkey).unwrap().push(worry_level);
            }
            for (monkey_number, worry_levels) in todo_list {
                for worry_level in worry_levels {
                    self.monkeys[monkey_number].items.push(worry_level);
                }
            }
        }
    }

    fn calculate_monkey_business(&self) -> usize {
        // Go through each monkey, get the count of items, take the top two, then multiply
        let monkeys_copy = self.monkeys.clone();
        let mut item_counts: Vec<usize> = monkeys_copy.into_iter().map(|m| m.checked_items_count).collect();
        println!("item_counts: {:?}", item_counts);
        item_counts.sort();
        println!("item_counts: {:?}", item_counts);

        // Pop last two elements off and multiply together
        (0..2).fold(1, |result, _| {
            result * item_counts.pop().expect("Unable to pop value")
        })
    }

    fn solve_part1(&mut self) -> usize {
        for _ in 0..PART1_ROUNDS {
            self.play_round();
        }
        self.calculate_monkey_business()
    }
}

fn main() {
    println!("Hello world");

    let input_file = "input.txt";

    let mut monkey_business = MonkeyBusiness::from_file(input_file);
    println!("monkey_business: {:?}", monkey_business);

    println!("Part 1 answer: {}", monkey_business.solve_part1());
    //     println!("Part 2 answer: {}", top_level.solve_part2());
}

#[derive(Clone, Debug, PartialEq)]
struct Monkey {
    items: Vec<usize>,
    operation: Operation,
    test_divisor: usize,
    divisor_results: DivisorResult,
    checked_items_count: usize,
}

impl Monkey {
    // fn new(raw_input: &str) {
    fn new(raw_input: &str) -> Self {
        let processed_input = raw_input
            .lines()
            .filter(|v| v != &"")
            .collect::<Vec<&str>>();

        // Set of the four variables needed to initialize
        let items: Vec<usize>;
        let operation: Operation;
        let test_divisor: usize;
        let divisor_results: DivisorResult;

        // Conditionally set values when matches found
        if let [_, raw_starting_items, raw_operation, raw_test_divisor, raw_true, raw_false] =
            &processed_input[..6]
        {
            items = starting_items_vec(raw_starting_items);
            operation = get_operation_data(raw_operation);
            test_divisor = get_test_divisor(raw_test_divisor);

            let mut true_false = String::from(*raw_true);
            let deref_false = String::from(*raw_false);
            true_false.push_str(&deref_false);

            divisor_results = get_divisor_results(&true_false);
        } else {
            items = vec![];
            operation = Operation {
                operation_type: OperationType::Addition,
                operation_value: 1,
            };
            test_divisor = 1;
            divisor_results = DivisorResult {
                true_monkey: 1,
                false_monkey: 1,
            };
        }
        Monkey {
            items,
            operation,
            test_divisor,
            divisor_results,
            checked_items_count: 0,
        }
    }
}
fn inspect_item(monkey: &Monkey, worry_level: usize) -> (usize, usize) {
    let mut result = worry_level;
    result = monkey.operation.compute(result);
    result = result / 3;
    match result % monkey.test_divisor {
        0 => (monkey.divisor_results.true_monkey, result),
        _ => (monkey.divisor_results.false_monkey, result),
    }
}

#[derive(Clone, Debug, PartialEq)]
enum OperationType {
    Addition,
    Multiplication,
    Exponent,
}

#[derive(Clone, Debug, PartialEq)]
struct Operation {
    operation_type: OperationType,
    operation_value: usize,
}

impl Operation {
    fn compute(&self, start_value: usize) -> usize {
        match self.operation_type {
            OperationType::Addition => start_value + self.operation_value,
            OperationType::Multiplication => start_value * self.operation_value,
            OperationType::Exponent => start_value * start_value,
        }
    }
}

#[derive(Clone, Debug, PartialEq)]
struct DivisorResult {
    true_monkey: usize,
    false_monkey: usize,
}

fn starting_items_vec(raw_text: &str) -> Vec<usize> {
    let re = Regex::new(r"\s+Starting items:\s{1}(?P<starting_items>.*)$").unwrap();

    let starting_items: Vec<usize> = re
        .captures(raw_text)
        .expect("No captures found for starting_items")
        .name("starting_items")
        .expect("no named group found for starting_items")
        .as_str()
        .split(", ")
        .map(|v| v.parse::<usize>().unwrap())
        .collect();
    starting_items
}

fn get_test_divisor(raw_text: &str) -> usize {
    let re = Regex::new(r"\s+Test:\s{1}divisible by (?P<divisor>\d+)$").unwrap();

    re.captures(raw_text)
        .expect("get_test_divisor did not have a capture")
        .name("divisor")
        .expect("divisor match group not found")
        .as_str()
        .parse::<usize>()
        .expect("Could not parse get_test_divisor into usize")
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
        .expect("no operation_value named capture group")
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
        r"\s+If true: throw to monkey (?P<true_monkey>\d+)\s+If false: throw to monkey (?P<false_monkey>\d)\s*$",
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
            get_divisor_results(
                "    If true: throw to monkey 0\n    If false: throw to monkey 1  "
            ),
            DivisorResult {
                true_monkey: 0,
                false_monkey: 1
            },
        );
    }

    fn raw_monkey_0_input() -> &'static str {
        "Monkey 0:\n
          Starting items: 79, 98\n
          Operation: new = old * 19\n
          Test: divisible by 23\n
            If true: throw to monkey 2\n
            If false: throw to monkey 3"
    }

    fn raw_monkey_2_input() -> &'static str {
        "Monkey 2:\n
          Starting items: 79, 60, 97\n
          Operation: new = old * old\n
          Test: divisible by 13\n
            If true: throw to monkey 1\n
            If false: throw to monkey 3"
    }

    #[test]
    fn test_monkey_new() {
        let monkey = Monkey::new(raw_monkey_0_input());
        assert_eq!(monkey.items, vec![79, 98]);
        assert_eq!(
            monkey.operation,
            Operation {
                operation_type: OperationType::Multiplication,
                operation_value: 19
            }
        );
        assert_eq!(monkey.test_divisor, 23);
        assert_eq!(
            monkey.divisor_results,
            DivisorResult {
                true_monkey: 2,
                false_monkey: 3
            }
        );
    }

    #[test]
    fn test_monkey_inspect_item() {
        let monkey = Monkey::new(raw_monkey_0_input());
        assert_eq!(inspect_item(&monkey, 98), (3, 620));

        let monkey = Monkey::new(raw_monkey_2_input());
        assert_eq!(inspect_item(&monkey, 79), (1, 2080));
    }

    #[test]
    fn test_monkey_business_from_file() {
        let monkey_business = MonkeyBusiness::from_file("test_input.txt");
        assert_eq!(monkey_business.monkeys.len(), 4);
        assert_eq!(monkey_business.monkeys[1].test_divisor, 19);
        assert_eq!(monkey_business.monkeys[2].items, vec![79, 60, 97]);
        assert_eq!(
            monkey_business.monkeys[3].operation,
            Operation {
                operation_type: OperationType::Addition,
                operation_value: 3
            }
        );
        assert_eq!(
            monkey_business.monkeys[3].divisor_results,
            DivisorResult {
                true_monkey: 0,
                false_monkey: 1,
            }
        );
    }

    #[test]
    fn test_monkey_business_round() {
        let mut monkey_business = MonkeyBusiness::from_file("test_input.txt");

        monkey_business.play_round();

        assert_eq!(monkey_business.monkeys[0].items, vec![20, 23, 27, 26]);
        assert_eq!(monkey_business.monkeys[0].checked_items_count, 2);

        assert_eq!(
            monkey_business.monkeys[1].items,
            vec![2080, 25, 167, 207, 401, 1046]
        );
        assert_eq!(monkey_business.monkeys[1].checked_items_count, 4);

        assert_eq!(monkey_business.monkeys[2].items, vec![]);
        assert_eq!(monkey_business.monkeys[2].checked_items_count, 3);

        assert_eq!(monkey_business.monkeys[3].items, vec![]);
        assert_eq!(monkey_business.monkeys[3].checked_items_count, 5);
    }

    #[test]
    fn test_monkey_business_multiple_rounds() {
        let mut monkey_business = MonkeyBusiness::from_file("test_input.txt");
        for _ in 0..PART1_ROUNDS {
            monkey_business.play_round();
        }

        assert_eq!(
            monkey_business.monkeys[0].items,
            vec![10, 12, 14, 26, 34]
        );
        assert_eq!(monkey_business.monkeys[0].checked_items_count, 101);

        assert_eq!(monkey_business.monkeys[1].items, vec![245, 93, 53, 199, 115]);
        assert_eq!(monkey_business.monkeys[1].checked_items_count, 95);

        assert_eq!(monkey_business.monkeys[2].items, vec![]);
        assert_eq!(monkey_business.monkeys[2].checked_items_count, 7);

        assert_eq!(monkey_business.monkeys[3].items, vec![]);
        assert_eq!(monkey_business.monkeys[3].checked_items_count, 105);

        assert_eq!(monkey_business.calculate_monkey_business(), 10605);
    }

    #[test]
    fn test_solve_part1() {
        let mut monkey_business = MonkeyBusiness::from_file("test_input.txt");
        assert_eq!(monkey_business.solve_part1(), 10605);
    }

    // #[test]
    // fn test_part2() {
    //     assert_eq!(22, 10);
    // }
}
