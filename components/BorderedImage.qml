//
// BorderedImage.qml
//
// This component is an image with support for rounded borders.
//

import QtQuick 2.7
import QtGraphicalEffects 1.0


Item {
  id: container

  property alias source: image.source
  property alias asynchronous: image.asynchronous
  property alias mipmap: image.mipmap
  property alias smooth: image.smooth
  property alias border: border.border
  property alias radius: border.radius

  Image {
    id: image
    anchors.fill: parent
    fillMode: Image.PreserveAspectFit

    clip: true
    visible: false
  }

  Rectangle {
    id: mask
    anchors.fill: parent

    color: "black"
    radius: border.radius

    clip: true
    visible: false
  }

  OpacityMask {
    id: masked_image
    anchors.fill: parent
    anchors.margins: border.border.width / 2

    source: image
    maskSource: mask
  }

  Rectangle {
    id: border
    anchors.fill: parent

    color: "transparent"
    border.color: "darkgray"
    radius: 3.0
  }
}
