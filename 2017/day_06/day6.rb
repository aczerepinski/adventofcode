class Array
  def redistribute
    i = find_max
    amount = self[i]
    self[i] = 0
    while amount > 0 do
      i += 1
      self[i % length] += 1
      amount -= 1
    end
  end

  def find_max
    max = 0
    idx = 0
    each_with_index do |n, i|
      if n > max
        max = n
        idx = i
      end
    end
    idx
  end
end

def first_occurance(n, states_seen)
  states_seen.each_with_index do |state, i|
    if state == n
      return i
    end
  end
end

def solve(input, solution_proc)
  array = input.split("\t").map{|n| n.to_i}
  states_seen = []
  loop do
    current_state = array.join("")
    if states_seen.include? current_state
      return solution_proc.call(states_seen, current_state)
    end
    states_seen << current_state
    array.redistribute
  end
end

def part_one(input)
  answer = Proc.new {|states_seen, final_state| states_seen.length}
  solve(input, answer)
end

def part_two(input)
  answer = Proc.new do |states_seen, final_state|
    states_seen.length - first_occurance(final_state, states_seen)
  end
  solve(input, answer)
end

file = File.open("input.txt", "r")
input = file.read()
file.close()

puts "part one answer: #{part_one(input)}"
puts "part two answer: #{part_two(input)}"