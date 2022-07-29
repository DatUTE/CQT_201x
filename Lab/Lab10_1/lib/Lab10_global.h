#ifndef LAB10_GLOBAL_H
#define LAB10_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(LAB10_LIBRARY)
#  define LAB10_EXPORT Q_DECL_EXPORT
#else
#  define LAB10_EXPORT Q_DECL_IMPORT
#endif

#endif // LAB10_GLOBAL_H
