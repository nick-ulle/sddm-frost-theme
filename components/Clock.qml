//
// Clock.qml
//
// This component is a clock with a customizable format.
//

import QtQuick 2.7


Column {
  id: container

  property date date_time: new Date()

  property string time_format: "h:mm AP"
  property alias time_color: time.color
  property alias time_font: time.font

  property string date_format: "MMMM d"
  property alias date_color: date.color
  property alias date_font: date.font

  Timer {
    interval: 100
    running: true
    repeat: true
    onTriggered: container.date_time = new Date()
  }

  Text {
    id: time
    text: Qt.formatTime(container.date_time, time_format)
  }

  Text {
    id: date
    text: Qt.formatDate(container.date_time, date_format)
  }
}
