use std::fs;

#[derive(Debug, PartialEq)]
struct Module {
    mass: u64,
}

impl Module {
    fn calculate_fuel(&self) -> u64 {
        let x: f64 = self.mass as f64 / 3.0;
        x.floor() as u64 - 2
    }
}

// fn read_input(file_path: &str) -> Vec<String> {
fn read_input(file_path: &str) -> Vec<u64> {
    let mut new_vec = vec![];
    // let mut new_vec: Vec<String> = Vec::new();
    // let contents = fs::read_to_string(file_path).expect("Unable to read file").split("\n").collect();

    // TODO: figure out why try the next three lines on one results in error E0716:
    // creates a temporary which is freed while still in use
    // let contents: Vec<&str> = fs::read_to_string(file_path).expect("Unable to read file").split("\n").collect();
    // println!("Got contents: {:?}", raw_contents);

    // Instead have to get the raw contents and then collect them :shrug:
    let raw_contents = fs::read_to_string(file_path).expect("Unable to read file");
    println!("Got raw_contents: {:?}", raw_contents);
    let contents: Vec<&str> = raw_contents.split("\n").collect();

    for line in contents {
        println!("Processing line: {}", line);
        // TODO: there must be a way to chomp final new line - just couldn't find it right away
        if line != "" {
            new_vec.push(
                line.to_string()
                .parse::<u64>()
                .expect("Unable to parse string to integer")
            );
        }
    }
    new_vec
}

// TODO: ditch these function once all is working as desired
fn sum_input(file_path: &str) -> u64 {
    read_input(file_path).iter().sum()
}

fn collect_modules(input_masses: Vec<u64>) -> Vec<Module> {
    let mut modules = vec![];
    for mass in input_masses.iter() {
        modules.push(Module { mass: *mass })
    }
    modules
}

fn part1(file_path: &str) -> u64 {
    let input_masses = read_input(file_path);
    let modules = collect_modules(input_masses);

    let mut fuel_calculations = vec![];
    for module in modules {
        fuel_calculations.push(module.calculate_fuel());
    }
    fuel_calculations.iter().sum()
}

fn main() {
    println!("Hello, world! Let's solve part 1");
    let input_file = "input.txt";
    let part1_answer = part1(input_file);
    println!("Part 1 answer: {}", part1_answer);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_calculate_fuel() {
        assert_eq!(Module { mass: 12 }.calculate_fuel(), 2);
        assert_eq!(Module { mass: 14 }.calculate_fuel(), 2);
        assert_eq!(Module { mass: 1969 }.calculate_fuel(), 654);
        assert_eq!(Module { mass: 100756 }.calculate_fuel(), 33583);
    }

    #[test]
    fn test_read_input() {
        assert_eq!(read_input("test_input.txt"), vec![12, 14, 1969, 100756])
    }

    #[test]
    fn test_collect_modules() {
        let input_masses = read_input("test_input.txt");
        assert_eq!(collect_modules(input_masses), vec![
            Module { mass: 12 },
            Module { mass: 14 },
            Module { mass: 1969 },
            Module { mass: 100756 },
        ])
    }

    #[test]
    fn test_part1() {
        let input_file = "test_input.txt";
        assert_eq!(part1(input_file), 34241);
    }

    #[test]
    // TODO: delete this test once it is all working =)
    fn test_sum_input() {
        assert_eq!(sum_input("test_input.txt"), 102751)
    }
}
