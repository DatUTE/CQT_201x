#ifndef LIGHTCONTROLER_H
#define LIGHTCONTROLER_H

#include <QObject>
#include "lightdisplay.h"
class LightControler : public QObject
{
    Q_OBJECT
public:
    LightControler();
    void sendData(int time, int signal);
signals:
    void signalSendData(int, int);
private:
    int m_time;
    int m_lightSignal;

};

#endif // LIGHTCONTROLER_H
