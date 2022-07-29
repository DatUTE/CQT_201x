#include "translation.h"

Translation::Translation( QGuiApplication *app, QObject *parent)
    : QObject(parent)
{
    translator1 = new QTranslator();
    translator2 = new QTranslator();
    // translator1->load("string_us",":/translator");
    // translator2->load("string_vn",":/translator");
}

QString Translation::getEmptyString()
{
    return "";
}

QString Translation::currentLanguage()
{
    return m_currentLanguage;
}

void Translation::setCurrentLanguage(QString language)
{
    m_currentLanguage = language;
    if (language == "us") {
        translator1->load("string_us", ":/translator");
        m_app->installTranslator(translator1);
    }
    if (language == "vn") {
        translator2->load("string_vn", ":/translator");
        m_app->installTranslator(translator2);
    }
}

void Translation::selectLanguage(QString language)
{
    setCurrentLanguage(language);
    emit languageChanged();
}

