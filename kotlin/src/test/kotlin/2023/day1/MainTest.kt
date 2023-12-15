import kotlin.test.Test
import kotlin.test.assertEquals

internal class dayOne2023Test {

    private val testInputFile = "src/main/kotlin/2023/day1/test_input.txt"

    @Test
    fun testPart1() {
        val expected = 142
        assertEquals(expected, part1(testInputFile))
    }
}
