const fs = require("fs/promises");

const main = async () => {
  const input = await readInput();
  run(input);
};

const run = (s: string) => {
  let floor = 0;
  let firstTimeInBasement = 0;
  let moves = 0;
  const chars = s.split("");

  chars.forEach((c) => {
    moves += 1;
    if (c === "(") {
      floor += 1;
    } else {
      floor -= 1;
      if (firstTimeInBasement == 0 && floor < 0) {
        firstTimeInBasement = moves;
      }
    }
  });

  console.log(floor);
  console.log(firstTimeInBasement);
};

const readInput = async (): Promise<string> => {
  try {
    const data = await fs.readFile("../input/2015-01.txt", {
      encoding: "utf8",
    });
    return data;
  } catch (err) {
    console.log(err);
    return "";
  }
};

main();
