<?hh

function countSteps(array $instructions, $increment): int {
    $stepsTaken = 0;
    $currentIndex = 0;
    while (true) {
        if ($currentIndex < 0 || $currentIndex >= count($instructions)) {
            return $stepsTaken;
        }
        $currentInstruction = $instructions[$currentIndex];
        $newIndex = $currentIndex + $currentInstruction;
        $instructions[$currentIndex] = $increment($currentInstruction);
        $currentIndex = $newIndex;
        $stepsTaken++;
    }
}

function partOne(array $instructions): int {
    $increment = $x ==> $x + 1;
    return countSteps($instructions, $increment);
}

function partTwo(array $instructions): int {
    $increment = $x ==> $x >= 3 ? $x - 1 : $x + 1;
    return countSteps($instructions, $increment);
}

$testList = file('./test_input.txt');
$list = file('./input.txt');

echo '<p>part one test: ' . partOne($testList) . '</p>';
echo '<p>part one solution: ' . partOne($list) . '</p>';
echo '<p>part two test: ' . partTwo($testList) . '</p>';
echo '<p>part two solution: ' . partTwo($list) . '</p>';