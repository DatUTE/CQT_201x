#ifndef LIGHTDISPLAY_H
#define LIGHTDISPLAY_H

#include <QObject>

class LightDisplay : public QObject
{
    Q_OBJECT
public:
    explicit LightDisplay(QObject *parent = nullptr);

public slots:
     void slotReceivedData(int, int);
private:
     int time;
};

#endif // LIGHTDISPLAY_H
