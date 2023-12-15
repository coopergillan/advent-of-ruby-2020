import kotlin.test.Test
import kotlin.test.assertEquals

internal class day1Test {

    private val testInputFile = "src/main/kotlin/2020/day1/test_input.txt"

    @Test
    fun testPart1() {
        val expected = 514579
        assertEquals(expected, part1(testInputFile))
    }

    @Test
    fun testPart2() {
        val expected = 241861950
        assertEquals(expected, part2(testInputFile))
    }
}
