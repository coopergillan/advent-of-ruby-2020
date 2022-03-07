struct Module {
    mass: u64,
}

impl Module {
    fn calculate_fuel(&self) -> u64 {
        let x: f64 = self.mass as f64 / 3.0;
        x.floor() as u64 - 2
    }
}

fn main() {
    println!("Hello, world!");
}

#[test]
fn test_calculate_fuel() {
    assert_eq!(Module { mass: 12 }.calculate_fuel(), 2);
    assert_eq!(Module { mass: 14 }.calculate_fuel(), 2);
    assert_eq!(Module { mass: 1969 }.calculate_fuel(), 654);
    assert_eq!(Module { mass: 100756 }.calculate_fuel(), 33583);
}
