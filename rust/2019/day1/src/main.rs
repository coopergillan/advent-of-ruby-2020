use std::fs;

#[derive(Debug, PartialEq)]
struct Module { mass: u64 }

impl Module {
    fn calculate_fuel_part1(&self) -> u64 {
        let x: f64 = self.mass as f64 / 3.0;
        x.floor() as u64 - 2
    }

    fn calculate_fuel_part2(&self) -> u64 {
        let x: f64 = self.mass as f64 / 3.0;
        x.floor() as u64 - 2
    }
}

fn read_input(file_path: &str) -> Vec<u64> {
    let raw_contents = fs::read_to_string(file_path).expect("Unable to read file");
    let contents = raw_contents.lines();
    contents
        .map(|line| {
            line.to_string()
                .parse::<u64>()
                .expect("Unable to parse string to integer")
        })
        .collect()
}

fn collect_modules(input_masses: Vec<u64>) -> Vec<Module> {
    input_masses
        .iter()
        .map(|mass| Module { mass: *mass })
        .collect()
}

fn part1(file_path: &str) -> u64 {
    let input_masses = read_input(file_path);
    let modules = collect_modules(input_masses);

    modules.iter().map(|module| module.calculate_fuel_part1()).sum()
}

fn main() {
    println!("Hello, world! Let's solve part 1");
    let input_file = "input.txt";

    println!("Part 1 answer: {}", part1(input_file));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_calculate_fuel_part1() {
        assert_eq!(Module { mass: 12 }.calculate_fuel_part1(), 2);
        assert_eq!(Module { mass: 14 }.calculate_fuel_part1(), 2);
        assert_eq!(Module { mass: 1969 }.calculate_fuel_part1(), 654);
        assert_eq!(Module { mass: 100756 }.calculate_fuel_part1(), 33583);
    }

    #[test]
    fn test_calculate_fuel_part2() {
        assert_eq!(Module { mass: 12 }.calculate_fuel_part2(), 2);
        assert_eq!(Module { mass: 14 }.calculate_fuel_part2(), 2);
        assert_eq!(Module { mass: 1969 }.calculate_fuel_part2(), 966);
        // assert_eq!(Module { mass: 100756 }.calculate_fuel_part2(), 50346);
    }

    #[test]
    fn test_read_input() {
        assert_eq!(read_input("test_input.txt"), vec![12, 14, 1969, 100756])
    }

    #[test]
    fn test_collect_modules() {
        let input_masses = read_input("test_input.txt");
        assert_eq!(
            collect_modules(input_masses),
            vec![
                Module { mass: 12 },
                Module { mass: 14 },
                Module { mass: 1969 },
                Module { mass: 100756 },
            ]
        )
    }

    #[test]
    fn test_part1() {
        let input_file = "test_input.txt";
        assert_eq!(part1(input_file), 34241);
    }
}
