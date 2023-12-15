import kotlin.test.Test
import kotlin.test.assertEquals

internal class day1Test {

    private val testPart1: Int = part1("src/main/kotlin/2020/day1/test_input.txt")

    @Test
    fun testPart1() {
        val expected = 514579
        assertEquals(expected, testPart1)
    }
}
