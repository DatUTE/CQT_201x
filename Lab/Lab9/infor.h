#ifndef INFOR_H
#define INFOR_H

#include <QObject>

class Infor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString dob READ dob WRITE setDob NOTIFY dobChanged)
    Q_PROPERTY(QString mssv READ mssv WRITE setMssv NOTIFY mssvChanged)
    Q_PROPERTY(QString email READ email WRITE setEmail NOTIFY emailChanged)
    Q_PROPERTY(int phone READ phone WRITE setPhone NOTIFY phoneChanged)
    Q_PROPERTY(QString add READ add WRITE setAdd NOTIFY addChanged)
    Q_PROPERTY(int gpa READ gpa WRITE setGpa NOTIFY gpaChanged)
public:
    explicit Infor(QObject *parent = nullptr);

    Infor (QString name, QString mssv, QString dob, QString email, int phone, QString add, double gpa);

    QString name();
    void setName(QString name);
    QString dob();
    void setDob(QString n_dob);
    QString mssv();
    void setMssv(QString mssv);
    QString email();
    void setEmail(QString email);
    int phone();
    void setPhone(int phone);
    QString add();
    void setAdd(QString add);
    int gpa();
    void setGpa(double gpa);

signals:
    void nameChanged();
    void dobChanged();
    void mssvChanged();
    void phoneChanged();
    void addChanged();
    void gpaChanged();
    void emailChanged();
private:
    QString m_name;
    QString m_dob;
    QString m_mssv;
    QString m_email;
    int m_phone;
    QString m_add;
    double m_gpa;
};

#endif // INFOR_H
