#include "lab10.h"
#include <math.h>
#include <QDebug>
Calculator::Calculator()
{
}

void Calculator::printBinary(int a)
{
    long long binaryNumber = 0;
    int p = 0;
    while (a > 0)
    {
        binaryNumber += (a%2) * pow(10,p);
        p++;
        a/=2;
    }
    qDebug() << binaryNumber;

}

void Calculator::printOcta(int a)
{
    long long octaNumber = 0;
    int p = 0;
    while (a > 0)
    {
        octaNumber += (a%2) *pow(8, p);
        p++;
        a /=2;
    }
    qDebug() << octaNumber;
}

void Calculator::printHexa(int a)
{
    long long hexaNumber = 0;
    int p = 0;
    while (a >0)
    {
        hexaNumber += (a%2)*pow(16, p);
        p++;
        a/= 2;
    }
    qDebug() << hexaNumber;
}

int Calculator::printAND(int a, int b)
{
    int c = 0;
    c = a&b;
    return c;

}

int Calculator::printOR(int a, int b)
{
    int c = 0;
    c = a|b;
    return c;

}

int Calculator::printXOR(int a, int b)
{
    int c = 0;
    c = a^b;
    return c;
}
