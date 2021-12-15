#-------------------------------------------------
# Copyright 2021 Esri.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#-------------------------------------------------

mac {
    cache()
}

#-------------------------------------------------------------------------------

CONFIG += c++14

# additional modules are pulled in via arcgisruntime.pri
QT += opengl qml quick

TEMPLATE = app
TARGET = DisplayOverviewMap

ARCGIS_RUNTIME_VERSION = 100.14
include($$PWD/arcgisruntime.pri)

# path of the toolkit relative to the sample
TOOLKIT_PRI_PATH = $$PWD/../../../arcgis-runtime-toolkit-qt

exists($$TOOLKIT_PRI_PATH/uitools/toolkitqml.pri) {
    include($$TOOLKIT_PRI_PATH/uitools/toolkitcpp.pri)
} else {
    error(TOOLKIT_PRI_PATH is missing which is required to build this application.)
}

#-------------------------------------------------------------------------------

HEADERS += \
    DisplayOverviewMap.h

SOURCES += \
    main.cpp \
    DisplayOverviewMap.cpp

RESOURCES += DisplayOverviewMap.qrc

#-------------------------------------------------------------------------------

win32 {
    LIBS += \
        Ole32.lib
}

ios {
    INCLUDEPATH += $$PWD
    DEPENDPATH += $$PWD

    OTHER_FILES += \
        $$PWD/Info.plist

    QMAKE_INFO_PLIST = $$PWD/Info.plist
}

android {
    INCLUDEPATH += $$PWD
    DEPENDPATH += $$PWD
}