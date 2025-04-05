%dw 2.0
output application/json

// $: value, $$: key
var towers = payload.towers mapObject (
  if (!isEmpty($)) // Tower with disks
    source: {name: $$, value: $} 
  else if ($$ ~= payload.targetTower) // Tower with the same name as targetTower
    target: {name: $$, value: $} 
  else  // Left tower - aux
    aux: {name: $$, value: $}
)
var moves = payload.moves

var toh = (disks, source, target, aux, moves) ->
  if (disks == 1) 
    moves + 1
  else do {
    var step1 = toh(disks - 1, source, aux, target, moves) // Move disks from source to aux
    var step2 = step1 + 1 // Increment the move count
    var step3 = toh(disks - 1, aux, target, source, step2) // Move disks from aux to target
    ---
    step3 // Return the total move count
  }

var finalTowers = {
  (towers.source.name): [],
  (towers.aux.name): [],
  (towers.target.name): 1 to payload.disks
}

---
{
  moves: toh(payload.disks, towers.source.name, towers.target.name, towers.aux.name, moves),
  disks: payload.disks,
  targetTower: payload.targetTower,
  towers: finalTowers orderBy($$),
  Explanation: {
      "Towers Var -  Separate the name and value for each tower": towers,
      "ToH Function - Count the number of moves": toh(payload.disks, towers.source.name, towers.target.name, towers.aux.name, moves)
  }
}
