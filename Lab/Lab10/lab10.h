#ifndef LAB10_H
#define LAB10_H

#include "Lab10_global.h"

class Calculator
{
public:
    Calculator();
    void printBinary(int a);
    void printOcta(int a);
    void printHexa(int a);
    int printAND(int a, int b);
    int printOR(int a, int b);
    int printXOR(int a, int b);
};

#endif // LAB10_H
