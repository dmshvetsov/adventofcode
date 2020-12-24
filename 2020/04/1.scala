import scala.io.Source

object Day4_1 {
  private val REQUIRED_KEYS = Set("ecl", "pid", "eyr", "hcl", "byr", "iyr", "hgt")

  def parseInput(filePath: String): Array[Set[String]] = {
    Source
      .fromFile(filePath)
      .mkString
      .split("\n\n")
      .map(passport => {
        val props : Array[String] = passport.replace("\n", " ").split(' ')
        val keys : Array[String] = props.map(prop => prop.split(':').head)
        keys.toSet
      })
  }

  def solution(data: Array[Set[String]]): Int = {
    data.count(passport => REQUIRED_KEYS.subsetOf(passport))
  }

  def main(args: Array[String]) {
    println(solution(parseInput("example_input.txt")))
    println(solution(parseInput("input.txt")))
  }
}
