// Advent of Code solver

use std::fs;

const MAP_SEPARATOR: &str = "\n\n";

fn part1(file_path: &str) -> isize {
    let raw_content = fs::read_to_string(file_path).expect("Unable to read file");
    let mut raw_mappings: Vec<&str> = raw_content.split(MAP_SEPARATOR).collect();
    println!(
        "Got raw_mappings before pulling seeds out: {:?}",
        raw_mappings
    );

    let raw_seeds = raw_mappings.remove(0);
    println!("Got raw_seeds: {:?}", &raw_seeds);

    let seeds: Vec<_> = raw_seeds
        .strip_prefix("seeds: ")
        .unwrap()
        .split_whitespace()
        .map(|val| val.parse::<isize>().expect("Unable to parse val"))
        .collect();

    println!("Processed seeds: {:?}", &seeds);

    7
}

fn translate_seed(seed_number: isize, raw_map_lines: &str) -> isize {
    let mut working_seed_number = seed_number.clone();

    for line in raw_map_lines.lines() {
        if line.ends_with(" map:") {
            continue;
        } else {
            let mut split_map = line.split_whitespace();
            let (dest_range_start, source_range_start, range_size) = (
                split_map.next().unwrap().parse::<isize>().unwrap(),
                split_map.next().unwrap().parse::<isize>().unwrap(),
                split_map.next().unwrap().parse::<isize>().unwrap(),
            );
            println!("dest_range_start: {:?}", dest_range_start);
            println!("source_range_start: {:?}", source_range_start);
            println!("range_size: {:?}", range_size);

            // Is the working seed number in the updated range?
            let range_end = source_range_start + range_size;
            if working_seed_number >= source_range_start && working_seed_number < range_end {
                println!(
                    "okay, working_seed_number {} is greater than or equal to source_range_start {} and less than source_range_start + range_size {}",
                    working_seed_number,
                    source_range_start,
                    source_range_start + range_size,
                );
                working_seed_number += dest_range_start - source_range_start;
                println!("set working_seed_number to {}", working_seed_number);
            }
        }
    }

    working_seed_number
}

fn main() {
    println!("Hello world");
    // let input_file = "test_double_line_break_input.txt";
    //
    // let top_level = TopLevelStructDoubleLineBreak::from_file(input_file);

    println!("Part 1 answer: {}", part1("test_input.txt"));
    // println!("Part 2 answer: {}", top_level.solve_part2());
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    #[ignore]
    fn test_translate_seed_two_lines() {
        let map_lines = r#"seed-to-soil map:
        50 98 2
        52 50 48"#;
        assert_eq!(translate_seed(79, map_lines), 81);
        assert_eq!(translate_seed(14, map_lines), 14);
        assert_eq!(translate_seed(55, map_lines), 57);
    }

    #[test]
    #[ignore]
    fn test_translate_seed_three_lines() {
        let map_lines = r#"soil-to-fertilizer map:
        0 15 37
        37 52 2
        39 0 15"#;
        assert_eq!(translate_seed(14, map_lines), 53);
        assert_eq!(translate_seed(57, map_lines), 57);
        assert_eq!(translate_seed(13, map_lines), 52);
    }

    #[test]
    fn test_translate_seed_four_lines() {
        let map_lines = r#"fertilizer-to-water map:
        49 53 8
        0 11 42
        42 0 7
        57 7 4"#;
        // assert_eq!(translate_seed(81, map_lines), 81);
        assert_eq!(translate_seed(53, map_lines), 49);
        // assert_eq!(translate_seed(57, map_lines), 53);
        // assert_eq!(translate_seed(52, map_lines), 41);
    }

    #[test]
    #[ignore]
    fn test_part1() {
        assert_eq!(5, 6);
    }

    #[test]
    #[ignore]
    fn test_part2() {
        assert_eq!(22, 10);
    }
}
