#include "lightcontroler.h"

LightControler::LightControler()
{
    m_time = 0;
    m_lightSignal = -1;
}

void LightControler::sendData(int time, int signal)
{
    if (m_time != time && m_lightSignal != signal)
    {
        m_time = time;
        m_lightSignal = signal;
    }
    emit signalSendData(time , signal);
}
