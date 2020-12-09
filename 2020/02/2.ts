import { readFileSync } from 'fs'

type Password = string
type Policy = {
  pos: [number, number],
  letter: string
}

console.log('Example:', solution(prepareInput(readInput('example_input'))))
console.log('Example:', solution(prepareInput(readInput('input'))))

function solution(data: [Policy, Password][]) {
  return data.reduce((validPswd, [policy, password], idx) => {
    if (isValid(password, policy)) {
      return validPswd + 1
    }
    return validPswd
  }, 0)
}

function isValid(password: Password, policy: Policy): boolean {
  const firstIdx = policy.pos[0] - 1
  const secondIdx = policy.pos[1] - 1
  return (password[firstIdx] === policy.letter) !== (password[secondIdx] === policy.letter)
}

function readInput(filePath: string): string[] {
  return readFileSync(filePath).toString('utf8').trim().split('\n')
}

function prepareInput(lines: string[]): [Policy, Password][] {
  return lines.map((line) => {
    const [posRule, letter, password] = line.split(' ')
    const [firstRule, secondRule] = posRule.split('-')
    const pos: [number, number] = [
      parseInt(firstRule, 10) || 0,
      parseInt(secondRule, 10) || 0
    ]
    const policy = {
      pos,
      letter: letter[0]
    }
    return [policy, password]
  })
}
