const parseDisc = line => {
  const captures = line.match(/([a-z]+)\s\((\d+)\)(.->.)*(.*)/)
  return {
    name: captures[1],
    weight: parseInt(captures[2], 10),
    childrenNames: captures[4].split(', ')
  }
}

const getRoot = discs => {
  notRoots = []
  discs.forEach((disc) => {
    disc.childrenNames.forEach((child) => {
      notRoots.push(child)
    })
  })
  const roots = discs.filter((disc) => notRoots.indexOf(disc.name) === -1)
  if (roots.length !== 1) {
    throw new Error(`expected one root, got ${roots.length}`)
  }
  return roots[0]
}

const getDescendentWeight = disc => {
  const children = getChildren(disc)
  if (!children) {
    return 0
  }
  const weights = children.map(c => c.weight)
    .reduce((acc, c) => acc + c)
  return weights + children.map(getDescendentWeight).reduce((acc, c) => acc + c)
}

const isBalanced = (disc) => {
  const children = getChildren(disc)
  if (!children) {
    return true
  }
  children.sort((a, b) => a.totalWeight - b.totalWeight)
  return children[0].totalWeight === children[children.length-1].totalWeight
}

const getChildren = (disc) => {
  const children = discs.filter((d) => (
    disc.childrenNames.indexOf(d.name) >= 0
  ))
  if (children.length === 0 || children[0] === '') {
    return null
  }
  return children
}

const calculateCorrectWeight = (discs) => {
  if (discs.length <= 2) {
    // there have to be 3 leafs at this node in order for the puzzle to have
    // only one correct answer
    throw new Error(`invalid puzzle`)
  }
  const sorted = discs.sort((a,b) => a.totalWeight - b.totalWeight)
  let unique, base
  if (sorted[0].totalWeight != sorted[1].totalWeight) {
    unique = sorted[0]
    base = sorted[1]
  } else {
    unique = sorted[sorted.length - 1]
    base = sorted[0]
  }
  if (base.totalWeight < unique.totalWeight) {
    return unique.weight - (unique.totalWeight - base.totalWeight)
  } else {
    return unique.weight + (base.totalWeight - unique.totalWeight)
  }
}

const solvePartOne = root => root.name

const solvePartTwo = root => {
  const children = getChildren(root)
  for (let i = 0; i < children.length; i++) {
    if (!isBalanced(children[i])) {
      return solvePartTwo(children[i])
    }
  }
 return calculateCorrectWeight(children)
}

const discs = input.split('\n').map(parseDisc)
discs.forEach(disc => disc.descendentWeight = getDescendentWeight(disc))
discs.forEach(disc => disc.totalWeight = disc.weight + disc.descendentWeight)
const root = getRoot(discs)
console.log(`part one answer: ${solvePartOne(root)}`)
console.log(`part two answer: ${solvePartTwo(root)}`)