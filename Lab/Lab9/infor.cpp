#include "infor.h"

Infor::Infor(QObject *parent)
    : QObject{parent},
      m_name(""),
      m_dob(""),
      m_mssv(""),
      m_email(""),
      m_phone(0),
      m_add(""),
      m_gpa(0)
{

}

Infor::Infor(QString name, QString mssv, QString dob, QString email, int phone, QString add, double gpa )
{
    m_name = name;
    m_mssv = mssv;
    m_dob  = dob;
    m_email = email;
    m_phone = phone;
    m_add = add;
    m_gpa = gpa;
}
QString Infor::dob()
{
    return m_dob;
}

QString Infor::mssv()
{
    return m_mssv;
}

void Infor::setMssv(QString mssv)
{
    if(m_mssv != mssv)
    {
        return;
    }
    m_mssv = mssv;
    emit mssvChanged();
}

QString Infor::email()
{
    return m_email;
}

void Infor::setEmail(QString email)
{
    if(m_email != email)
    {
        return;
    }
    m_email = email;
    emit emailChanged();
}

int Infor::phone()
{
    return m_phone;
}

void Infor::setPhone(int phone)
{
    if(m_phone != phone)
    {
        return;
    }
    m_phone = phone;
    emit phoneChanged();
}

QString Infor::add()
{
    return m_add;
}

void Infor::setAdd(QString add)
{
    if (m_add != add)
    {
        return;
    }
    m_add = add;
    emit addChanged();
}

int Infor::gpa()
{
    return m_gpa;
}

void Infor::setGpa(double gpa)
{
    if(m_gpa != gpa)
    {
        return;
    }
    m_gpa = gpa;
    emit gpaChanged();
}

QString Infor::name()
{
    return m_name;
}
void Infor::setName(QString name)
{
    if (m_name != name)
    {
        return;
    }
    m_name = name;
    emit nameChanged();
}
void Infor::setDob(QString dob)
{
    if (m_dob != dob)
    {
        return;
    }
    m_dob = dob;
    emit dobChanged();
}
