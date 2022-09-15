#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>

using namespace std;

class AnimatedGif
{
public:
    AnimatedGif(bool isCornersLit);
    void runAnimation(int steps);
    int getLightCount();

private:
    int width = 1000;
    int height = 1000;
    char lightOn = '#';
    char lightOff = '.';
    bool isCornersLit;
    vector<vector<char>> matrix;
    void turnOnCornerLights();
    void turnOnLight(int x, int y);
    char getNewState(char value, int adjacentOnCount);
    vector<vector<char>> buildMatrixFromInput();
    vector<vector<char>> buildMatrix();
    int countAdjacentLights(int x, int y);
    int isLightOn(int x, int y);
    bool isValidCoord(int x, int y);
};

AnimatedGif::AnimatedGif(bool isCornersLit)
{
    isCornersLit = isCornersLit;
    matrix = buildMatrix();
    if (isCornersLit)
        turnOnCornerLights();
}

int AnimatedGif::getLightCount()
{
    int count = 0;
    for (int x = 0; x < width; x++)
    {
        for (int y = 0; y < width; y++)
        {
            if (matrix[y][x] == lightOn)
            {
                count++;
            }
        }
    }
    return count;
}

void AnimatedGif::runAnimation(int steps)
{
    for (int i = 0; i < steps; i++)
    {
        vector<vector<char>> newMatrix = buildMatrix();
        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                int adjacentCount = countAdjacentLights(x, y);
                int newState = getNewState(matrix[y][x], adjacentCount);
                newMatrix[y][x] = newState;
            }
        }

        matrix = newMatrix;
        if (isCornersLit)
            turnOnCornerLights();
    }
}

int AnimatedGif::countAdjacentLights(int x, int y)
{
    int count = 0;
    count += isLightOn(x, y - 1);
    count += isLightOn(x + 1, y - 1);
    count += isLightOn(x + 1, y);
    count += isLightOn(x + 1, y + 1);
    count += isLightOn(x, y + 1);
    count += isLightOn(x - 1, y + 1);
    count += isLightOn(x - 1, y);
    count += isLightOn(x - 1, y - 1);
    return count;
}

int AnimatedGif::isLightOn(int x, int y)
{
    return isValidCoord(x, y) && matrix[y][x] == lightOn;
}

bool AnimatedGif::isValidCoord(int x, int y)
{
    return x >= 0 && x < width && y >= 0 && y < height;
}

void AnimatedGif::turnOnCornerLights()
{
    int xMax = width - 1;
    int yMax = height - 1;
    turnOnLight(0, 0);
    turnOnLight(xMax, 0);
    turnOnLight(xMax, yMax);
    turnOnLight(0, yMax);
}

void AnimatedGif::turnOnLight(int x, int y)
{
    matrix[x][y] = lightOn;
}

char AnimatedGif::getNewState(char value, int adjacentOnCount)
{
    if (value == lightOn)
    {
        return adjacentOnCount == 2 || adjacentOnCount == 3
                   ? lightOn
                   : lightOff;
    }

    return adjacentOnCount == 3
               ? lightOn
               : lightOff;
}

vector<vector<char>> AnimatedGif::buildMatrix()
{
    vector<vector<char>> m(1000);
    for (int y = 0; y < height; y++)
    {
        vector<char> row(1000, lightOff);
        m[y] = row;
    }

    return m;
}

vector<vector<char>> AnimatedGif::buildMatrixFromInput()
{
    fstream newfile;
    vector<vector<char>> m = buildMatrix();
    newfile.open("input.txt", ios::in);
    if (newfile.is_open())
    {
        string line;
        int y = 0;
        while (getline(newfile, line))
        {
            for (int x = 0; x < width; x++)
            {
                m[y][x] = line[x];
            }
            y++;
        }
        newfile.close();
    }

    return m;
}

int main()
{
    AnimatedGif gif(false);
    gif.runAnimation(100);
    int part1 = gif.getLightCount();
    cout << part1 << endl;
}