import unittest

def part_one(input_path):
    return solve(input_path, False)


def part_two(input_path):
    return solve(input_path, True)


def solve(input_path, is_part_two):
    with open(input_path) as f:
        (registers, instructions) = parse_input(f)
        high_water_mark = 0
        for instruction in instructions:
            if should_execute_instruction(instruction, registers):
                val = new_value(instruction, registers)
                registers[instruction['register']] = val
                high_water_mark = val if val > high_water_mark else high_water_mark
        if is_part_two:
            return high_water_mark
        else:
            return max(registers.values())


def parse_input(input):
    registers = {}
    instructions = []
    for line in input:
        # scy inc -688 if hwk < -1797
        parts = line.split(' ')
        registers[parts[0]] = 0
        instruction = {
            'register': parts[0],
            'operator': parts[1],
            'amount': int(parts[2]),
            'conditional_register': parts[4],
            'comparison_operator': parts[5],
            'comparison_amount': int(parts[6]),
        }
        instructions.append(instruction)
    return (registers, instructions)


def should_execute_instruction(inst, registers):
    comp = '{} {} {}'.format(registers[inst['conditional_register']],
            inst['comparison_operator'], inst['comparison_amount'])
    return eval(comp)


def new_value(inst, registers):
    old_val = registers[inst['register']]
    if inst['operator'] == 'inc':
        return old_val + inst['amount']
    else:
        return old_val - inst['amount']


class TestDayEight(unittest.TestCase):
    def test_part_one(self):
        input_path = './test_input.txt'
        self.assertEqual(part_one(input_path), 1)
    
    def test_part_two(self):
        input_path = './test_input.txt'
        self.assertEqual(part_two(input_path), 10)

if __name__ == '__main__':
    unittest.main()

print('part one: {0}'.format(part_one('./input.txt')))
print('part two: {0}'.format(part_two('./input.txt')))