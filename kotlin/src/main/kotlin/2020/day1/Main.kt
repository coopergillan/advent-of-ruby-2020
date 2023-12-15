import java.io.File

fun part1(inputFile: String): Int {
    val numbers = File(inputFile)
        .readLines()
        .map(String::toInt)

    for (first in numbers) {
        for (second in numbers) {
            if (first + second == 2020) {
                return first * second
            }
        }
    }
    return 0
}

fun main() {
    val partOneAnswer = part1("src/main/kotlin/2020/day1/input.txt")
    println("Part one answer: $partOneAnswer")
}
