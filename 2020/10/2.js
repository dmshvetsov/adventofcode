const fs = require('fs')

console.log('Example:', solution(prepareInput(readInput('example_input'))))
console.log('Solution:', solution(prepareInput(readInput('input'))))

function solution(data) {
  return data.reduce((computed, jolt) => {
    computed[jolt] =
      (computed[jolt - 3] || 0) +
      (computed[jolt - 2] || 0) +
      (computed[jolt - 1] || 0)
    return computed
  }, [1]).pop();
}

function readInput(filePath) {
  return fs.readFileSync(filePath).toString('utf8').trim().split('\n')
}

function prepareInput(lines) {
  return lines.map((line) => parseInt(line.trim(), 10)).sort((a, b) => a - b)
}
