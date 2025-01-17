// [WriteFile Name=DisplayMap, Category=Maps]
// [Legal]
// Copyright 2015 Esri.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// [Legal]

#include "DisplayMap.h"
#include "Map.h"
#include "MapGraphicsView.h"
#include <QVBoxLayout>

using namespace Esri::ArcGISRuntime;

DisplayMap::DisplayMap(QWidget* parent) :
  QWidget(parent)
{
    // Create a map using the Imagery with labels basemap
    m_map = new Map(BasemapStyle::ArcGISImagery, this);

    // Create a map view, and pass in the map
    m_mapView = new MapGraphicsView(m_map, this);

    // Set up the UI
    QVBoxLayout *vBoxLayout = new QVBoxLayout();
    vBoxLayout->addWidget(m_mapView);
    setLayout(vBoxLayout);
}

DisplayMap::~DisplayMap() = default;
