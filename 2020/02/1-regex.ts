import { readFileSync } from 'fs'

type Password = string
type Policy = {
  low: number
  high: number
  letter: string
}

console.log('Example:', solution(prepareInput(readInput('example_input'))))
console.log('Example:', solution(prepareInput(readInput('input'))))

function solution(data: [Policy, Password][]) {
  return data.reduce((validPswd, [policy, password]) => {
    const match = password.match(new RegExp(policy.letter, 'g'))
    if (match && policy.low <= match.length && match.length <= policy.high) {
      return validPswd += 1
    }
    return validPswd
  }, 0)
}

function readInput(filePath: string): string[] {
  return readFileSync(filePath).toString('utf8').trim().split('\n')
}

function prepareInput(lines: string[]): [Policy, Password][] {
  return lines.map((line) => {
    const [lowHighRule, letter, password] = line.split(' ')
    const [low, high] = lowHighRule.split('-')
    const policy = {
      low: parseInt(low, 10),
      high: parseInt(high, 10),
      letter: letter[0]
    }
    return [policy, password]
  })
}

