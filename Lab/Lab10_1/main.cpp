#include <QCoreApplication>
#include <QDebug>
#include "lib/lab10.h"

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    Calculator cal;
    qDebug() << "in so nhi phan: " ;
    cal.printBinary(5);
    qDebug() << "in so bat phan: " ;
    cal.printOcta(5);
    qDebug() << "in so he thap luc phan: " ;
    cal.printHexa(5);
    qDebug() << "A OR B = " << cal.printOR(10,20);
    qDebug() << "A AND B = " << cal.printAND(10,20);
    qDebug() << "A XOR B = " << cal.printXOR(10,20);

    return a.exec();
}
