use std::fs;

const CARD_NUMBER_SEPARATOR: char = ':';
const CARD_NUMBER_PREFIX: &str = "Card ";
const CARD_DETAILS_SEPARATOR: char = '|';

fn main() {
    println!(
        "The cards in part one are worth {} in total",
        solve_part1("input.txt")
    );
}

fn solve_part1(input_file_path: &str) -> usize {
    fs::read_to_string(input_file_path)
        .expect("Unable to read file contents")
        .lines()
        .map(|card_info| part1_parse(card_info))
        .sum()
}

fn part1_parse(raw_input: &str) -> usize {
    let mut winning: Vec<usize> = vec![];
    let mut owned: Vec<usize> = vec![];

    for subset in raw_input.split([CARD_NUMBER_SEPARATOR]).map(|v| v.trim()) {
        // println!("subset: {:?}", subset);
        if subset.starts_with(CARD_NUMBER_PREFIX) {
            continue;
        }

        let mut split_card_input = subset.split(CARD_DETAILS_SEPARATOR).map(|v| v.trim());
        // println!("split_card_input: {:?}", split_card_input);

        let (raw_winning, raw_owned) = (
            split_card_input
                .next()
                .expect("Unable to get winning cards"),
            split_card_input.next().expect("Unable to get owned cards"),
        );

        // println!("raw_winning: {:?}", raw_winning);
        // println!("raw_owned: {:?}", raw_owned);

        winning = raw_winning
            .split_whitespace()
            .map(|num| {
                num.parse::<usize>()
                    .expect("Unable to parse integer for winning cards")
            })
            .collect();
        // println!("winning: {:?}", winning);

        owned = raw_owned
            .split_whitespace()
            .map(|num| {
                num.parse::<usize>()
                    .expect("Unable to parse integer for winning cards")
            })
            .collect();
        // println!("owned: {:?}", owned);
        break;
    }
    score_winning_cards(winning, owned)
}

fn score_winning_cards(winning_cards: Vec<usize>, owned_cards: Vec<usize>) -> usize {
    let mut score = 0;
    for owned_card in &owned_cards {
        if winning_cards.contains(owned_card) {
            match score {
                0 => score = 1,
                _ => score *= 2,
            }
        }
    }
    score
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_solve_part1() {
        assert_eq!(solve_part1("test_input.txt"), 13);
    }

    #[test]
    fn test_part1_parse() {
        let card1 = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53";
        assert_eq!(part1_parse(card1), 8);
    }

    #[test]
    fn test_score_winning_cards() {
        let winning_cards = vec![41, 48, 83, 86, 17];
        let owned_cards = vec![83, 86, 6, 31, 17, 9, 48, 53];
        assert_eq!(score_winning_cards(winning_cards, owned_cards), 8);

        let winning_cards = vec![13, 32, 20, 16, 61];
        let owned_cards = vec![61, 30, 68, 82, 17, 32, 24, 19];
        assert_eq!(score_winning_cards(winning_cards, owned_cards), 2);

        let winning_cards = vec![87, 83, 26, 28, 32];
        let owned_cards = vec![88, 30, 70, 12, 93, 22, 82, 36];
        assert_eq!(score_winning_cards(winning_cards, owned_cards), 0);
    }
}
