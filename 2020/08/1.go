package main

import (
  "bufio"
  "fmt"
  "os"
  "strings"
  "strconv"
  "log"
)

type Instruction struct {
  name string
  arg int
}

func main() {
  fmt.Println(solution(prepareData(readInput("example_input"))))
  fmt.Println(solution(prepareData(readInput("input"))))
}

func solution(data []Instruction) (int) {
  executed := map[int]bool{}
  acc := 0
  idx := 0
  for idx < len(data) {
    instr := data[idx]
    if executed[idx] {
      return acc
    }
    executed[idx] = true
    if instr.name == "nop" {
      idx = idx + 1
      continue
    }
    if instr.name == "acc" {
      acc = acc + instr.arg
      idx = idx + 1
      continue
    }
    if instr.name == "jmp" {
      idx = idx + instr.arg
      continue
    }
    log.Fatal("Unknow instruction detected")
  }
  return acc
}

func prepareData(lines []string) ([]Instruction) {
  var prepared []Instruction
  for _, line := range lines {
    parts := strings.Split(strings.TrimSpace(line), " ")
    arg, err := strconv.Atoi(parts[1])
    if err != nil {
      log.Fatal(err)
    }
    prepared = append(prepared, Instruction{parts[0], arg})
  }
  return prepared
}

func readInput(path string) ([]string) {
  file, err := os.Open(path)
  if err != nil {
    log.Fatal(err)
  }
  defer file.Close()

  scanner := bufio.NewScanner(file)
  var lines []string
  for scanner.Scan() {
    lines = append(lines, scanner.Text())
  }

  if err := scanner.Err(); err != nil {
    log.Fatal(err)
  }

  return lines
}
