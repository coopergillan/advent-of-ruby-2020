// Advent of Code solver

use std::fs;

#[derive(Debug)]
struct ElfDetails {
    elf_list: Vec<Elf>,
}

impl ElfDetails {
    fn new(elf_list: Vec<Elf>) -> Self {
        Self { elf_list }
    }

    fn from_file(file_path: &str) -> Self {
        // For reading each line into an array
        let raw_content = fs::read_to_string(file_path).expect("Unable to read file");

        let processed_contents: Vec<Elf> = raw_content
            .split("\n\n")
            .map(|elf_raw| {
                let calorie_details = elf_raw
                    .lines()
                    .map(|v| v.parse::<usize>().expect("Unable to parse"))
                    .collect();
                Elf::new(calorie_details)
            })
            .collect::<Vec<Elf>>();

        Self::new(processed_contents)
    }

    fn solve_part1(&self) -> usize {
        self.elf_list
            .iter()
            .map(|elf| elf.total_calories())
            .max()
            .expect("Unable to get maximum value")
    }

    // fn solve_part2(&self) -> usize {
    //     7
    // }
}

#[derive(Debug, PartialEq)]
struct Elf {
    calorie_details: Vec<usize>,
}

impl Elf {
    fn new(calorie_details: Vec<usize>) -> Self {
        Elf { calorie_details }
    }

    fn total_calories(&self) -> usize {
        self.calorie_details.iter().sum::<usize>()
    }
}

fn main() {
    println!("Hello world");
    let input_file = "input.txt";

    let top_level = ElfDetails::from_file(input_file);

    println!("Part 1 answer: {}", top_level.solve_part1());
    // println!("Part 2 answer: {}", top_level.solve_part2());
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_elf_total_calories() {
        let elf = Elf::new(vec![1000, 2000, 3000]);
        assert_eq!(elf.total_calories(), 6000);
    }

    fn test_elf_list() -> ElfDetails {
        let input_file = "test_input.txt";
        ElfDetails::from_file(input_file)
    }

    #[test]
    fn test_from_file() {
        let input_file = "test_input.txt";
        let elf_details = ElfDetails::from_file(input_file);
        println!("elf_details.elf_list: {:?}", elf_details.elf_list);
        assert_eq!(
            elf_details.elf_list,
            vec![
                Elf::new(vec![1000, 2000, 3000]),
                Elf::new(vec![4000]),
                Elf::new(vec![5000, 6000]),
                Elf::new(vec![7000, 8000, 9000]),
                Elf::new(vec![10000]),
            ],
        )
    }

    #[test]
    fn test_part1() {
        assert_eq!(test_elf_list().solve_part1(), 24000);
    }

    // #[test]
    // #[ignore]
    // fn test_part2() {
    //     assert_eq!(22, 10);
    // }
}
