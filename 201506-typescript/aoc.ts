const fs = require("fs/promises");

const main = async () => {
  const input = await readInput();
  run(input);
};

const run = (input: string) => {
  runPart1(input);
  runPart2(input);
};

const runPart1 = (input: string) => {
  const commands = parseCommands(input, false);
  const matrix = createMatrix();

  applyCommands(matrix, commands);

  const lightCount = measureMatrix(matrix);

  console.log(lightCount);
};

const runPart2 = (input: string) => {
  const commands = parseCommands(input, true);
  const matrix = createMatrix();

  applyCommands(matrix, commands);

  const brightness = measureMatrix(matrix);

  console.log(brightness);
};

const applyCommands = (matrix: number[][], commands: ICommand[]) => {
  commands.forEach((command) => {
    applyCommand(matrix, command);
  });
};

const applyCommand = (matrix: number[][], command: ICommand) => {
  for (let y = command.ya; y <= command.yb; y++) {
    matrix.push([]);
    for (let x = command.xa; x <= command.xb; x++) {
      if (command.type === "turnon") matrix[y][x] = 1;
      else if (command.type === "turnoff") matrix[y][x] = 0;
      else if (command.type === "toggle")
        matrix[y][x] = matrix[y][x] === 0 ? 1 : 0;
      else if (command.type === "increase") {
        matrix[y][x]++;
      } else if (command.type === "increasedouble") {
        matrix[y][x] += 2;
      } else if (command.type === "decrease") {
        const v = matrix[y][x] - 1;
        matrix[y][x] = v < 0 ? 0 : v;
      }
    }
  }
};

const measureMatrix = (matrix: number[][]) => {
  let count = 0;
  for (let y = 0; y < 1000; y++) {
    for (let x = 0; x < 1000; x++) {
      count += matrix[y][x];
    }
  }
  return count;
};

const parseCommands = (input: string, useBrightness: boolean) => {
  return input.split("\n").map((o) => {
    return createCommand(o.trim(), useBrightness);
  });
};

const createCommand = (s: string, useBrightness: boolean): ICommand => {
  const type = getCommandType(s, useBrightness);
  var paramString = s
    .replace("turn on", "")
    .replace("turn off", "")
    .replace("toggle", "");
  var strCoords = paramString.trim().split(" through ");
  var a = strCoords[0].split(",");
  var b = strCoords[1].split(",");
  const xa = parseInt(a[0]);
  const ya = parseInt(a[1]);
  const xb = parseInt(b[0]);
  const yb = parseInt(b[1]);
  return {
    type,
    xa,
    ya,
    xb,
    yb,
  };
};

const createMatrix = () => {
  const matrix: number[][] = [];
  for (let y = 0; y < 1000; y++) {
    matrix.push([]);
    for (let x = 0; x < 1000; x++) {
      matrix[y].push(0);
    }
  }
  return matrix;
};

const getCommandType = (s: string, useBrightness: boolean): CommandType => {
  if (s.startsWith("turn on")) {
    return useBrightness ? "increase" : "turnon";
  }
  if (s.startsWith("turn off")) {
    return useBrightness ? "decrease" : "turnoff";
  }
  return useBrightness ? "increasedouble" : "toggle";
};

const readInput = async (): Promise<string> => {
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

interface ICommand {
  type: CommandType;
  xa: number;
  ya: number;
  xb: number;
  yb: number;
}

type CommandType =
  | "turnon"
  | "turnoff"
  | "toggle"
  | "increase"
  | "increasedouble"
  | "decrease";
