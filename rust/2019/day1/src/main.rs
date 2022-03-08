use std::fs;

#[derive(Debug, PartialEq)]
struct Module {
    mass: i64,
}

impl Module {
    fn calculate_fuel_part1(&self) -> i64 {
        calculate_fuel(self.mass)
    }

    fn calculate_fuel_part2(&self) -> i64 {
        let mut total_fuel: i64 = 0;
        let mut mass = self.mass;

        loop {
            let next_fuel = calculate_fuel(mass);
            total_fuel += next_fuel;
            if next_fuel == 0 {
                return total_fuel;
            } else {
                mass = next_fuel
            }
        }
    }
}

fn calculate_fuel(mass: i64) -> i64 {
    // TODO: add a match statement or `if let` here for cleaner logic? Not able to get something right now.
    let mut fuel = (mass / 3) - 2;
    if fuel <= 0 {
        fuel = 0;
    }
    fuel
}

fn read_input(file_path: &str) -> Vec<i64> {
    let raw_contents = fs::read_to_string(file_path).expect("Unable to read file");
    let contents = raw_contents.lines();
    contents
        .map(|line| {
            line.to_string()
                .parse::<i64>()
                .expect("Unable to parse string to integer")
        })
        .collect()
}

fn collect_modules(input_masses: Vec<i64>) -> Vec<Module> {
    input_masses
        .iter()
        .map(|mass| Module { mass: *mass })
        .collect()
}

fn part1(file_path: &str) -> i64 {
    let input_masses = read_input(file_path);
    let modules = collect_modules(input_masses);

    modules
        .iter()
        .map(|module| module.calculate_fuel_part1())
        .sum()
}

fn part2(file_path: &str) -> i64 {
    let input_masses = read_input(file_path);
    let modules = collect_modules(input_masses);

    modules
        .iter()
        .map(|module| module.calculate_fuel_part2())
        .sum()
}

fn main() {
    let input_file = "input.txt";

    println!("Part 1 answer: {}", part1(input_file));
    println!("Part 2 answer: {}", part2(input_file));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_calculate_fuel() {
        assert_eq!(calculate_fuel(12), 2);
        assert_eq!(calculate_fuel(14), 2);
        assert_eq!(calculate_fuel(1969), 654);
        assert_eq!(calculate_fuel(100756), 33583);
    }

    #[test]
    fn test_calculate_fuel_part1_is_same_as_calculate_fuel() {
        let test_masses = vec![12, 14, 1969, 100756];
        test_masses
            .iter()
            .map(|mass| {
                assert_eq!(
                    Module { mass: *mass }.calculate_fuel_part1(),
                    calculate_fuel(*mass)
                )
            })
            .collect()
    }

    #[test]
    fn test_calculate_fuel_part2() {
        assert_eq!(Module { mass: 12 }.calculate_fuel_part2(), 2);
        assert_eq!(Module { mass: 14 }.calculate_fuel_part2(), 2);
        assert_eq!(Module { mass: 1969 }.calculate_fuel_part2(), 966);
        assert_eq!(Module { mass: 100756 }.calculate_fuel_part2(), 50346);
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

    #[test]
    fn test_part2() {
        let input_file = "test_input.txt";
        assert_eq!(part2(input_file), 51316);
    }
}
