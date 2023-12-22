use std::fs;

fn first_and_last_int(input_data: &str) -> usize {
    let mut parsed = vec![];

    for maybe_char in input_data.chars() {
        match maybe_char.to_digit(10) {
            Some(num) => parsed.push(num.to_string()),
            _ => continue,
        }
    }

    let mut answer = vec![];
    answer.push(parsed.first().unwrap().to_owned());
    answer.push(parsed.last().unwrap().to_owned());
    answer
        .concat()
        .parse::<usize>()
        .expect("Unable to concatenate")
}

fn solve_part1(input_file_path: &str) -> usize {
    fs::read_to_string(input_file_path)
        .expect("Unable to read file contents")
        .lines()
        .map(|v| first_and_last_int(v))
        .sum()
}

fn main() {
    let part1_answer = solve_part1("input.txt");
    println!("Part one: {:?}", part1_answer);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_solve_part1() {
        assert_eq!(solve_part1("test_input.txt"), 142);
    }

    #[test]
    fn test_first_and_last_int() {
        let input_data = "1abc2";
        assert_eq!(first_and_last_int(input_data), 12);

        let input_data = "pqr3stu8vwx";
        assert_eq!(first_and_last_int(input_data), 38);
    }

    #[test]
    fn test_more_than_two_ints() {
        let input_data = "a1b2c3d4e5f";
        assert_eq!(first_and_last_int(input_data), 15);
    }

    #[test]
    fn test_just_one_int() {
        let input_data = "treb7uchet";
        assert_eq!(first_and_last_int(input_data), 77);
    }

    // #[test]
    // fn test_both_numbers_are_strings() {
    //     let input_data = "two1nine";
    //     assert_eq!(first_and_last_num(input_data), 29);
    // }
}
