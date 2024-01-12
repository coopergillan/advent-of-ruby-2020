use std::collections::HashMap;
use std::fs;

const CARD_NUMBER_SEPARATOR: char = ':';
const CARD_NUMBER_PREFIX: &str = "Card ";
const CARD_DETAILS_SEPARATOR: char = '|';

fn main() {
    println!(
        "The cards in part one are worth {} in total",
        solve_part1("input.txt")
    );
    println!(
        "The cards in part two are worth {} in total",
        solve_part2("input.txt")
    );
}

fn solve_part2(input_file_path: &str) -> usize {
    let mut matching_cards = HashMap::new();

    for (idx, raw_line) in fs::read_to_string(input_file_path)
        .expect("Unable to read file contents")
        .lines()
        .enumerate()
    {
        let card_num = idx + 1;

        // Increment count of cards for the one copy being checked
        *matching_cards.entry(card_num).or_insert(0) += 1;

        match find_winners(raw_line).len() {
            0 => continue,
            win_count => {
                // Add one copy of each card based on count for each copy already owned
                let current_card_count = matching_cards
                    .get(&card_num)
                    .expect("Unable to get current matching card")
                    .clone();

                for i in 1..=win_count {
                    let new_copy_card_num = card_num + i;
                    *matching_cards.entry(new_copy_card_num).or_insert(0) += current_card_count;
                }
            }
        }
    }
    matching_cards.values().sum()
}

fn solve_part1(input_file_path: &str) -> usize {
    fs::read_to_string(input_file_path)
        .expect("Unable to read file contents")
        .lines()
        .map(|card_info| part1_parse(card_info))
        .sum()
}

fn part1_parse(raw_input: &str) -> usize {
    part1_score(find_winners(raw_input))
}

fn find_winners(raw_input: &str) -> Vec<usize> {
    let mut winning: Vec<usize> = vec![];
    let mut owned: Vec<usize> = vec![];

    for subset in raw_input.split([CARD_NUMBER_SEPARATOR]).map(|v| v.trim()) {
        if subset.starts_with(CARD_NUMBER_PREFIX) {
            continue;
        }

        let mut split_card_input = subset.split(CARD_DETAILS_SEPARATOR).map(|v| v.trim());

        let (raw_winning, raw_owned) = (
            split_card_input
                .next()
                .expect("Unable to get winning cards"),
            split_card_input.next().expect("Unable to get owned cards"),
        );

        winning = raw_winning
            .split_whitespace()
            .map(|num| {
                num.parse::<usize>()
                    .expect("Unable to parse integer for winning cards")
            })
            .collect();

        owned = raw_owned
            .split_whitespace()
            .map(|num| {
                num.parse::<usize>()
                    .expect("Unable to parse integer for winning cards")
            })
            .collect();
    }

    let mut won_cards = vec![];

    for owned_card in &owned {
        if winning.contains(owned_card) {
            won_cards.push(owned_card.to_owned());
        }
    }
    won_cards
}

// fn find_winners(winning_cards: Vec<usize>, owned_cards: Vec<usize>) -> Vec<usize> {}

fn part1_score(won_cards: Vec<usize>) -> usize {
    won_cards.iter().fold(0, |score, _card| match score {
        0 => score + 1,
        _ => score * 2,
    })
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
    fn test_find_winners() {
        assert_eq!(
            find_winners("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"),
            vec![83, 86, 17, 48]
        );

        assert_eq!(
            find_winners("Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"),
            vec![]
        );
    }

    #[test]
    fn test_part1_score() {
        assert_eq!(part1_score(vec![83, 86, 17, 48]), 8);
        assert_eq!(part1_score(vec![15, 27, 33]), 4);
        assert_eq!(part1_score(vec![11, 97]), 2);
        assert_eq!(part1_score(vec![10]), 1);
        assert_eq!(part1_score(vec![]), 0);
    }

    #[test]
    fn test_solve_part2() {
        assert_eq!(solve_part2("test_input.txt"), 30);
    }
}
