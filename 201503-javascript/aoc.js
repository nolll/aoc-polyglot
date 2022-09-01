const fs = require('fs/promises');

const main = async () => {
  const input = await readInput();
  run(input);
};

const run = (input) => {
  var instructions = input.split('');
  var part1Result = deliverBySanta(instructions);
  var part2Result = deliverBySantaAndRobot(instructions);
  
  console.log(part1Result);
  console.log(part2Result);
};

const deliverBySanta = (instructions) => {
  const houses = {};
  deliverAccordingToInstructions(instructions, houses);
   
  return countHouses(houses);
};

const deliverBySantaAndRobot = (instructions) => {
  const houses = {};
  const santaInstructions = [];
  const robotInstructions = [];

  for(let i = 0; i < instructions.length; i++){
    if(i % 2 == 0)
      santaInstructions.push(instructions[i]);
    else
      robotInstructions.push(instructions[i]);
  }

  deliverAccordingToInstructions(santaInstructions, houses);
  deliverAccordingToInstructions(robotInstructions, houses);

  return countHouses(houses);
};

const deliverAccordingToInstructions = (instructions, houses) => {
  let x = 0;
  let y = 0;

  deliverPresent(houses, x, y)

  instructions.forEach(instruction => {
    if(instruction === '>')
      x++;
    else if(instruction === 'v')
      y++;
    else if(instruction === '<')
      x--;
    else
      y--;
    
    deliverPresent(houses, x, y)
  });
};

const deliverPresent = (houses, x, y) => {
  const key = getKey(x, y);
  if(!houses[key]){
    houses[key] = 0;
  }
  houses[key]++;
};

const countHouses = (houses) => {
  let count = 0;
  for(var key in houses) {
    count++;
  }

  return count;
};

const getKey = (x, y) => {
  return `${x},${y}`;
};

const readInput = async () => {
  try {
    const data = await fs.readFile("input.txt", {
      encoding: "utf8",
    });
    return data;
  } catch (err) {
    console.log(err);
    return "";
  }
};

main();
