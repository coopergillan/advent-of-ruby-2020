import java.io.File

fun numbersFromFile(inputFile: String): List<Int> {
    return File(inputFile)
        .readLines()
        .map(String::toInt)
}

fun part1(inputFile: String): Int {
    val numbers = numbersFromFile(inputFile)

    for (first in numbers) {
        for (second in numbers) {
            if (first + second == 2020) {
                return first * second
            }
        }
    }
    return 0
}

fun part2(inputFile: String): Int {
    val numbers = numbersFromFile(inputFile)

    for (first in numbers) {
        for (second in numbers) {
            for (third in numbers) {
                if (first + second + third == 2020) {
                    return first * second * third
                }
            }
        }
    }
    return 0
}

fun main() {
    val mainInputFile = "src/main/kotlin/2020/day1/input.txt"
    val part1Answer = part1(mainInputFile)
    println("Part one answer: $part1Answer")

    val part2Answer = part2(mainInputFile)
    println("Part two answer: $part2Answer")
}
