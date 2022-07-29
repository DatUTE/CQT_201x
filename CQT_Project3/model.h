#ifndef MODEL_H
#define MODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QStringList>

class Model
{
public:
    Model(QString &title, QString &singer, QUrl(url));
    QString title() const;
    QString signer() const;
    QUrl url();
private:
    QString m_title;
    QString m_singer;
    QString m_url;
};
class



#endif // MODEL_H
