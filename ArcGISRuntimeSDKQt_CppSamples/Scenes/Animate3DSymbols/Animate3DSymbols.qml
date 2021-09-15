// [WriteFile Name=Animate3DSymbols, Category=Scenes]
// [Legal]
// Copyright 2016 Esri.

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

import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Esri.Samples 1.0

Animate3DSymbolsSample {
    id: rootRectangle

    property bool following: followButton.checked

    missionFrame: progressSlider.value
    zoom: cameraDistance.value
    angle: cameraAngle.value

    onNextFrameRequested: {
        progressSlider.value = progressSlider.value + 1;
        if (progressSlider.value >= missionSize)
            progressSlider.value = 0;
    }

    Component.onCompleted: {
        missionList.currentIndex = 0;
    }

    SceneView {
        id: sceneView
        objectName: "sceneView"
        anchors.fill: parent

        GridLayout {
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                bottom: sceneView.attributionTop
                margins: 10
            }

            columns: 2

            ComboBox {
                id: missionList
                enabled: !playButton.checked
                model: missionsModel
                textRole: "display"
                property real modelWidth: 0
                Layout.minimumWidth: leftPadding + rightPadding + indicator.width + modelWidth

                onModelChanged: {
                    for (let i = 0; i < missionsModel.rowCount(); ++i) {
                        const index = missionsModel.index(i, 0);
                        textMetrics.text = missionsModel.data(index);
                        modelWidth = Math.max(modelWidth, textMetrics.width);
                    }
                }

                onCurrentTextChanged: {
                    changeMission(currentText);
                    progressSlider.value = 0;
                }

                TextMetrics {
                    id: textMetrics
                    font: missionList.font
                }

                Component.onCompleted: missionList.currentTextChanged()
            }

            LabeledSlider {
                id: cameraDistance
                Layout.alignment: Qt.AlignRight
                from: 10.0
                to: 5000.0
                value: 500.0
                text: "zoom"
            }

            RowLayout {
                Button {
                    id: playButton
                    checked: false
                    checkable: true
                    enabled: missionReady
                    text: checked ? "pause" : "play"
                }

                Button {
                    id: followButton
                    Layout.alignment: Qt.AlignRight
                    enabled: missionReady
                    text: checked? "fixed" : "follow "
                    checked: true
                    checkable: true
                    onCheckedChanged: setFollowing(checked);
                }
            }

            LabeledSlider {
                id: cameraAngle
                Layout.alignment: Qt.AlignRight
                from: 0
                to: 180.0
                value: 45.0
                text: "angle"
            }

            LabeledSlider {
                id: progressSlider
                from: 0
                to: missionSize
                enabled : missionReady
                text: (value / missionSize * 100).toLocaleString(Qt.locale(), 'f', 0) + "%"
                handleWidth: progressMetrics.width
                TextMetrics {
                    id: progressMetrics
                    font: progressSlider.font
                    text: "100%"
                }
            }

            LabeledSlider {
                id: animationSpeed
                Layout.alignment: Qt.AlignRight
                from: 1
                to: 100
                value: 50
                text: "speed"
            }
        }
    }

    Timer {
        id: timer
        interval: 16.0 + 84 * (animationSpeed.to - animationSpeed.value) / 100.0;
        running: playButton.checked;
        repeat: true
        onTriggered: animate();
    }
}
