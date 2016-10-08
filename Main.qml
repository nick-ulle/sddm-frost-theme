
import QtQuick 2.7
import QtQuick.Controls 2.0
import SddmComponents 2.0 as Sddm

import "components"


Item {
  id: container
  property variant geometry: screenModel.geometry(screenModel.primary)
  property real unit: Math.max(8, 0.01 * width)

  width: geometry.width
  height: geometry.height

  Sddm.TextConstants {
    id: textConstants
  }

  Sddm.Background {
    anchors.fill: parent
    source: config.background
    fillMode: Image.PreserveAspectCrop
  }

  Clock {
    id: clock

    anchors {
      top: login_pane.top
      right: login_pane.left
      rightMargin: 2.0 * unit
    }

    time_color: "#FFF"
    time_font {
      family: config.font
      pixelSize: 3.0 * date_font.pixelSize
    }

    date_color: "#FFF"
    date_font {
      family: config.font
      pixelSize: 1.5 * unit
    }
  }

  ShadowPane {
    id: login_pane
    anchors.centerIn: parent
    width: 0.21 * parent.width
    height: dialog_col.height + 4 * unit

    Column {
      id: dialog_col

      spacing: unit
      anchors {
        verticalCenter: parent.verticalCenter
        left: parent.left
        right: parent.right
        leftMargin: 2 * unit
        rightMargin: 2 * unit
      }


      ListView {
				id: avatar
        anchors.horizontalCenter: parent.horizontalCenter
				width: 0.4 * parent.width
        height: width

				model: userModel

        delegate: BorderedImage {
          width: avatar.width
          height: avatar.height

          source: icon
          asynchronous: true
          mipmap: true
        }
			}

      TextField {
        id: username

        width: parent.width
        font.family: config.font
        font.pointSize: config.font_size
        background: Rectangle {
          radius: 3.0
          border.color: parent.focus ? "#407ee7" : "darkgray"
        }
        placeholderText: "Username"

        text: userModel.lastUser
        onAccepted: {
          sddm.login(username.text, password.text, session.currentIndex)
        }
      }

      TextField {
        id: password

        width: parent.width
        font.family: config.font
        font.pointSize: config.font_size
        background: Rectangle {
          radius: 3.0
          border.color: parent.focus ? "#407ee7" : "darkgray"
        }
        placeholderText: "Password"
        echoMode: TextInput.Password

        // Fix password focus
        // https://quickgit.kde.org/?p=plasma-workspace.git&
        // a=commitdiff&h=dfc4b8b2a0e2b012f68f0192e29081ee230e8c03
        Timer {
          interval: 200
          running: true
          repeat: false
          onTriggered: password.forceActiveFocus()
        }

        onAccepted: {
          sddm.login(username.text, password.text, session.currentIndex)
        }
      } // end password

      ComboBox {
        id: session

        z: 1000
        width: parent.width
        font.family: config.font
        font.pointSize: config.font_size
        background: Rectangle {
          radius: 3.0
          border.color: parent.focus ? "#407ee7" : "darkgray"
        }

        currentIndex: model.lastIndex
        model: sessionModel
        textRole: "name"
        indicator: Text {
          x: parent.width - width - parent.rightPadding
          y: parent.topPadding + (parent.availableHeight - height) / 2
          text: ""
          font.family: "FontAwesome"
          font.pixelSize: 1.0 * unit
          color: "darkgray"
        }

        delegate: ItemDelegate {
          width: session.width
          font.family: config.font
          font.pointSize: config.font_size
          highlighted: session.highlightedIndex == index

          text: model[session.textRole]
        }
      }

      ColorButton {
        id: login_button

        width: parent.width
        text: textConstants.login
        font.family: config.font
        font.pointSize: config.font_size
        color: "#FFF"

        background: Rectangle {
          radius: 3.0
          color: parent.down ? "#FF5ab738" : "#DD5ab738"
        }

        onClicked: {
          sddm.login(username.text, password.text, session.currentIndex)
        }
      }
    }
  }

  ShadowPane {
    id: shutdown_pane

    width: ctl_row.width + 4 * unit
    height: ctl_row.height + 4 * unit
    anchors {
      bottom: login_pane.bottom
      left: login_pane.right
      leftMargin: unit
    }
    
    Column {
      id: ctl_row
      anchors.centerIn: parent
      spacing: unit

      ColorButton {
        id: reboot

        width: unit
        height: unit
        text: ""
        font.family: "FontAwesome"
        font.pixelSize: 0.8 * unit
        color: "#FFF"

        background: Rectangle {
          radius: 3.0
          color: parent.down ? "#FF407ee7" : "#DD407ee7"
        }

        onClicked: sddm.reboot()
      }

      ColorButton {
        id: shutdown

        width: unit
        height: unit
        text: ""
        font.family: "FontAwesome"
        font.pixelSize: 0.8 * unit
        color: "#FFF"

        background: Rectangle {
          radius: 3.0
          color: parent.down ? "#FFf22c40" : "#DDf22c40"
        }

        onClicked: sddm.powerOff()
      }

    } // end Column
  }
}
