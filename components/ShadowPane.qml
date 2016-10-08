//
// ShadowPane.qml
//
// This component is a resizable rectangle with drop shadows and transparency
// support.
//

import QtQuick 2.7
import QtGraphicalEffects 1.0


Item {
  id: container
  default property alias data: foreground.data

  property alias pane_opacity: background.opacity
  property alias pane_color:   pane.color
  property alias pane_radius:  pane.radius

  property alias shadow_color:   shadow.color
  property alias shadow_radius:  shadow.radius
  property alias shadow_spread:  shadow.spread
  property alias shadow_hoffset: shadow.horizontalOffset
  property alias shadow_voffset: shadow.verticalOffset

  // This item holds only the background rectangle and drop shadow, so that
  // their opacity doesn't affect foreground components.
  Item {
    id: background

    anchors.fill: parent
    opacity: 0.5
    layer.enabled: true

    Rectangle {
      id: pane
      // This formula ensures no clipping even at maximum spread.
      readonly property real margin: Math.max(8, shadow_radius / 2)

      anchors {
        fill: parent
        topMargin:    Math.max(0, margin - shadow_voffset)
        bottomMargin: Math.max(0, margin + shadow_voffset)
        leftMargin:   Math.max(0, margin - shadow_hoffset)
        rightMargin:  Math.max(0, margin + shadow_hoffset)
      }
      color: "#FFFFFFFF"
      radius: 1.5
    }

    DropShadow {
      id: shadow

      anchors.fill: pane
      color: "#88000000"
      source: pane
      horizontalOffset: 0.0
      verticalOffset: 2.0
      radius: 10 // smoothness
      samples: 2 * radius + 1
      spread: 0.2
      cached: true
    }
  }

  // This item holds the components added by users.
  Item {
    id: foreground

    anchors {
      fill: parent
      topMargin:    pane.anchors.topMargin
      bottomMargin: pane.anchors.bottomMargin
      leftMargin:   pane.anchors.leftMargin
      rightMargin:  pane.anchors.rightMargin
    }
  }

}
