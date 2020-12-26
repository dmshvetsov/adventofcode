# inspired by https://gist.github.com/andreypopp/6036fe8dcb891534f15c0d741f68f2f6

import sys

args = sys.argv[1:]
file_path = args[0] if args and args[0] else 'input.txt'

rules_data, message_data = open(file_path, 'r').read().split('\n\n')
strings = message_data.split('\n')
rules = {}

# Build rules
for line in rules_data.split('\n'):
    k, rule = line.split(': ')
    if rule[0] == '"':
        rule = rule[1:-1]
    else:
        rule = [seq.split(' ') if ' ' in seq else [seq]
                for seq in (rule.split(' | ') if ' | ' in rule else [rule])]
    rules[k] = rule

def run_seq(rules, seq, msg):
    if not seq:
        yield msg
    else:
        next_k, *rest_seq = seq
        for rest_msg in run(rules, next_k, msg):
            yield from run_seq(rules, rest_seq, rest_msg)

def run(rules, k, msg):
    if isinstance(rules[k], list):
        # current rule are options
        for seq in rules[k]:
            yield from run_seq(rules, seq, msg)
    else:
        # current rule is leave (a leeter)
        if msg and msg[0] == rules[k]:
            # yield reminder
            yield msg[1:]

def match(rules, msg):
    # if any recursive match return empty string then it is a valid msg
    return any(rem == '' for rem in run(rules, '0', msg))

print('Part 1:', sum(match(rules, msg) for msg in strings))
rules = {**rules, '8': [['42'], ['42', '8']], '11': [['42', '31'], ['42', '11', '31']]}
print('Part 2:', sum(match(rules, msg) for msg in strings))
