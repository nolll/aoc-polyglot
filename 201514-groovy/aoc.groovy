main()

def main() {
    rows = readInput()
    run(rows, 2503)
}

def run(input, time) {
    var reindeers = parseReindeers(input)
    winningDistance = reindeers.collect(o -> o.distanceAfter(time)).max()
    winningScore = getWinningScore(reindeers, time)

    println(winningDistance)
    println(winningScore)
}

def getWinningScore(reindeers, time) {
    for (var i = 1; i <= time; i++) {
        var distances = []
        reindeers.each { reindeer ->
            distances.add(new ReindeerDistance(reindeer.distanceAfter(i), reindeer))
        }

        var ordered = distances.collect()
        ordered.sort(o -> o.distance)
        ordered = ordered.reverse()
        var maxValue = ordered.first().distance
        var leaders = ordered.findAll{ it.distance == maxValue }.collect(o -> o.reindeer)

        leaders.each { leader ->
            leader.increaseScore()
        }
    }
    return reindeers.score.max()
}

def parseReindeers(rows) {
    return rows.collect(o -> parseReindeer(o))
}

def parseReindeer(str) {
    var parts = str.split(' ')
    var name = parts[0]
    var speed = parts[3] as Integer
    var flyTime = parts[6] as Integer
    var restTime = parts[13] as Integer

    return new Reindeer(name, speed, flyTime, restTime)
}

def readInput() {
    File file = new File("input.txt")
    return file.readLines()
}

class Reindeer {
    Integer period
    String name
    Integer speed
    Integer flyTime
    Integer restTime
    Integer score

    Reindeer(name, speed, flyTime, restTime) {
        this.name = name
        this.speed = speed
        this.flyTime = flyTime
        this.restTime = restTime
        this.score = 0
        this.period = flyTime + restTime
    }

    def increaseScore() {
        this.score += 1
    }

    def distanceAfter(seconds) {
        var completedPeriods = (int)Math.floor(seconds / this.period)
        var secondsInCurrentPeriod = seconds % this.period
        var flySecondsInCurrentPeriod = secondsInCurrentPeriod > this.flyTime
            ? this.flyTime
            : secondsInCurrentPeriod

        var totalFlySeconds = completedPeriods * this.flyTime + flySecondsInCurrentPeriod
        return totalFlySeconds * this.speed
    }
}

class ReindeerDistance {
    Integer distance
    Reindeer reindeer

    ReindeerDistance(distance, reindeer){
        this.distance = distance
        this.reindeer = reindeer
    }
}