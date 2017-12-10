import Foundation

// returns (score, groupsCounted)
func solve(input: String) -> (Int, Int, Int) {
    var groupsCounted = 0
    var score = 0
    var shouldNegate = false
    var insideGarbage = false
    var currentDepth = 0
    var garbageChars = 0
    for s in input {
        if shouldNegate {
            shouldNegate = false
        } else if s == "!" {
            shouldNegate = true
        } else if !insideGarbage && s == "<" {
            insideGarbage = true
        } else if insideGarbage {
            if s == ">" {
                insideGarbage = false
            } else {
                garbageChars += 1
            }
        } else if s == "{" {
            currentDepth += 1
        } else if s == "}" {
            groupsCounted += 1
            score += currentDepth
            currentDepth -= 1
        }
    }
    return (score, groupsCounted, garbageChars)
}

var partOneTests = [
    "{}": 1,
    "{{{}}}": 6,
    "{{},{}}": 5,
    "{{{},{},{{}}}}": 16,
    "{<a>,<a>,<a>,<a>}": 1,
    "{{<ab>},{<ab>},{<ab>},{<ab>}}": 9,
    "{{<!!>},{<!!>},{<!!>},{<!!>}}": 9,
    "{{<a!>},{<a!>},{<a!>},{<ab>}}": 3,
]

for (input, expected) in partOneTests {
    let (actual, _, _) = solve(input: input)
    if actual != expected {
        print("score tests: expected \(input) to be \(expected), got \(actual)")
    }
}

var groupsCountedTests = [
    "{}": 1,
    "{{{}}}": 3,
    "{{},{}}": 3,
    "{{{},{},{{}}}}": 6,
    "{<{},{},{{}}>}": 1,
    "{<a>,<a>,<a>,<a>}": 1,
    "{{<a>},{<a>},{<a>},{<a>}}": 5,
    "{{<!>},{<!>},{<!>},{<a>}}": 2,
]

for (input, expected) in groupsCountedTests {
    let (_, actual, _) = solve(input: input)
    if actual != expected {
        print("counted tests: expected \(input) to be \(expected), got \(actual)")
    }
}

var garbageTests = [
    "<>": 0,
    "<random characters>" : 17,
    "<<<<>": 3,
    "<{!>}>": 2,
    "<!!>" : 0,
    "<!!!>>": 0,
    "<{o\"i!a,<{i<a>": 10  ,
]

for (input, expected) in garbageTests {
    let (_, _, actual) = solve(input: input)
    if actual != expected {
        print("garbage tests: expected \(input) to be \(expected), got \(actual)")
    }
}
let path = "./input.txt"
let input = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
let (answer, _, garbage) = solve(input: input)
print("answer to part one is \(answer)")
print("answer to part two is \(garbage)")