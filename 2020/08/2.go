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
  fmt.Println("Example:", solution(prepareData(readInput("example_input"))))
  fmt.Println("Answer:", solution(prepareData(readInput("input"))))
}

func solution(data []Instruction) (int) {
  executed := map[int]bool{}
  return track(data, 0, executed, 0, 0)
}

func track(data []Instruction, acc int, executed map[int]bool, idx int, tweaked int) int {
  if executed[idx] || tweaked > 1 {
    return 0
  }
  if !(idx < len(data)) {
    return acc
  }
  executed[idx] = true
  instr := data[idx]
  switch instr.name {
  case "nop":
    // executing jmp instead will get us to the last instruction
    return track(data, acc, executed, idx + 1, tweaked) + track(data, acc, executed, idx + instr.arg, tweaked + 1)
  case "acc":
    return track(data, acc + instr.arg, executed, idx + 1, tweaked)
  case "jmp":
    // executing nop instead will get us to the last instruction
    return track(data, acc, executed, idx + instr.arg, tweaked) + track(data, acc, executed, idx + 1, tweaked + 1)
  default:
    log.Fatal("Something went wrong... fix it")
  }
  log.Fatal("How did I get here?")
  // FIXME: how to avoid
  return 0
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
