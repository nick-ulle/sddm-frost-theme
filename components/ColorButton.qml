//
// ColorButton.qml
//
//

import QtQuick 2.7
import QtQuick.Controls 2.0


Button {
  id: button

  property alias color: text.color

  contentItem: Text {
    id: text
    
    text: parent.text
    font: parent.font
    anchors.fill: parent
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight
  }
}
