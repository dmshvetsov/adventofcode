const fs = require('fs')

console.log('Example:', solution(prepareInput(readInput('example_input'))))
console.log('Solution:', solution(prepareInput(readInput('input'))))

function solution(data) {
  const jolts = data.reduce((acc, jolt, idx, all) => {
    const prev = all[idx - 1]
    const diff = jolt - (prev || 0)
    acc[diff] += 1
    return acc
  }, { 1: 0, 3: 1 })
  return jolts['1'] * jolts['3']
}

function readInput(filePath) {
  return fs.readFileSync(filePath).toString('utf8').trim().split('\n')
}

function prepareInput(lines) {
  return lines.map((line) => parseInt(line.trim(), 10)).sort((a, b) => a - b)
}
