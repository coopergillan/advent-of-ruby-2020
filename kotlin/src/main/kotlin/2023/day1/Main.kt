import java.io.File

// fun readFile(inputFile: String): List<String> {
//     return File(inputFile).readLines()
// }

fun part1(inputFile: String): Int {
    val rawInput: List<String> = File(inputFile).readLines()

    for (line in rawInput) {

        // val parsedLine: String = ""

        for (char in line) {
            println(char)

        // val parsedLine: List<Int> = line.map(String::toInt)
        // println(parsedLine)
        }
    }

    // val rawInput = readFile(inputFile)
    // println(rawInput)
    return 142
}

fun main() {
    val inputFile = "src/main/kotlin/2023/day1/input.txt"
    val part1Answer = part1(inputFile)
    println("Part one answer: $part1Answer")
}
