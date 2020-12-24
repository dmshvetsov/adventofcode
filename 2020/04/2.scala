import scala.io.Source
import scala.collection.immutable.Map
import scala.util.matching.Regex

object Day4_2 {

  class Passport(props: Map[String, String]) {
    private val REQUIRED_KEYS = Set("ecl", "pid", "eyr", "hcl", "byr", "iyr", "hgt")
    private val BYR_RANGE = (1920, 2002)
    private val IYR_RANGE = (2010, 2020)
    private val EYR_RANGE = (2020, 2030)
    private val HGT_RE = "^[0-9]*(cm|in)$".r
    private val HGT_CM_RANGE = (150, 193)
    private val HGT_IN_RANGE = (59, 76)
    private val ECL = Set("amb", "blu", "brn", "gry", "grn", "hzl", "oth")
    private val HCL_RE = "^#[0-9a-f]{6}$".r
    private val PID_RE = "^[0-9]{9}$".r

    def isValid(): Boolean = {
      if (!REQUIRED_KEYS.subsetOf(props.keys.toSet)) return false
      if (!ECL(props.getOrElse("ecl", ""))) return false
      if (!HCL_RE.matches(props.getOrElse("hcl", ""))) return false
      if (!PID_RE.matches(props.getOrElse("pid", ""))) return false
      if (!HGT_RE.matches(props.getOrElse("hgt", ""))) return false
      if (
        props.get("hgt") match {
          case Some(str) => {
            val unit = str.takeRight(2)
            val hgt = str.dropRight(2).toInt
            if (unit == "in") {
              HGT_IN_RANGE._1 > hgt || hgt > HGT_IN_RANGE._2
            }
            else {
              HGT_CM_RANGE._1 > hgt || hgt > HGT_CM_RANGE._2
            }
          }
          case None => false
        }
      ) return false
      if ({
        val byr = props.get("byr") match {
          case Some(str) => str.toInt
          case None => -1
        }
        BYR_RANGE._1 > byr || byr > BYR_RANGE._2
      }) return false
      if ({
        val iyr  = props.get("iyr") match {
          case Some(str) => str.toInt
          case None => -1
        }
        IYR_RANGE._1 > iyr || iyr > IYR_RANGE._2
      }) return false
      if ({
        val eyr  = props.get("eyr") match {
          case Some(str) => str.toInt
          case None => -1
        }
        EYR_RANGE._1 > eyr || eyr > EYR_RANGE._2
      }) return false
      return true
    }
  }

  def parseInput(filePath: String): Array[Passport] = {
    Source
      .fromFile(filePath)
      .mkString
      .split("\n\n")
      .map(passportLine => {
        val props : Map[String, String] = passportLine
          .replace("\n", " ")
          .split(' ')
          .map(_.split(":"))
          .map(keyVal => keyVal(0) -> keyVal(1)).toMap
        new Passport(props)
      })
  }

  def solution(data: Array[Passport]): Int = {
    data.filter(_.isValid).size
  }

  def main(args: Array[String]) {
    println(s"Invalid example, valid num: ${solution(parseInput("example_invalid.txt"))}")
    println(s"Valid example, valid num: ${solution(parseInput("example_valid.txt"))}")
    println(solution(parseInput("input.txt")))
  }
}
