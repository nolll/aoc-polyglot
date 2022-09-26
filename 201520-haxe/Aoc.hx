using Lambda;

class Aoc {
	static public function main() {
		var input = 34000000;

		var part1 = deliver1(input, true);
		trace(part1);

		var part2 = deliver2(input);
		trace(part2);
	}
}

function deliver1(target, useOptimization) {
	var house = findLowerbound(target);

	while (true) {
		var hasAllLowFactors = !useOptimization || hasAllLowFactors(house);
		if (hasAllLowFactors) {
			var factors = findIntFactors(house);
			var presentCount = factors.fold(sum, 0) * 10;
			if (presentCount >= target) {
				return house;
			}
		}

		house++;
	}
}

function sum(num, total) {
	return total += num;
}

function findLowerbound(target) {
	var result = 0;
	var i = 1;
	while (true) {
		var nextResult = result + i * 10;

		if (nextResult > target)
			return i;

		result = nextResult;

		i++;
	}
}

function findIntFactors(target) {
	var factors:Array<Int> = [];
	var i = Math.floor(target / 2);
	while (i > 0) {
		if (target % i == 0) {
			factors.push(i);
		}

		i--;
	}

	factors.push(target);
	return factors;
}

function hasAllLowFactors(target) {
	if (target % 2 != 0)
		return false;
	if (target % 3 != 0)
		return false;
	if (target % 4 != 0)
		return false;
	if (target % 5 != 0)
		return false;
	if (target % 6 != 0)
		return false;
	if (target % 7 != 0)
		return false;
	if (target % 8 != 0)
		return false;
	if (target % 9 != 0)
		return false;
	if (target % 10 != 0)
		return false;
	return true;
}

function deliver2(target) {
	var houses:haxe.ds.Vector<Int> = new haxe.ds.Vector(target * 11);
	var elf = 1;

	while (elf <= target / 11) {
		var val = elf * 11;
		var house = elf;
		while (house <= elf * 50) {
			var oldVal = houses[house];
			if (oldVal == null) {
				oldVal = 0;
			}
			houses[house] = oldVal + val;
			house = house + elf;
		}

		elf = elf + 1;
	}

	for (key in 1...target) {
		var value = houses[key];
		if (value >= target)
			return key;
	}

	return 0;
}

function sort(a:Int, b:Int):Int {
	if (a < b) {
		return -1;
	} else if (a > b) {
		return 1;
	} else {
		return 0;
	}
}
