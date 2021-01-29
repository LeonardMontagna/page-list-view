import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Window {
    width: 480
    height: 800
    visible: true

    Rectangle {
        anchors.fill: parent
        color: "black"

        //        Button {
        //            text: "Add\nItem"
        //            anchors {
        //                top: parent.top
        //                left: parent.left
        //                topMargin: 50
        //                leftMargin: 50
        //            }
        //            height: 100
        //            width: 100
        //            onClicked: pagesModel.setTotalItems(val)
        //        }
    }

    ComboBox {
        id: chambers
        editable: true
        anchors {
            top: parent.top
            left: parent.left
            topMargin: 50
            leftMargin: 50
        }

        model: ListModel {
            id: model

            ListElement {

                text: "3"
            }
            ListElement {
                text: "4"
            }
            ListElement {
                text: "5"
            }
        }
        onActivated: {
            pagesModel.setTotalItems(chambers.currentText)
        }
    }

    Text {
        width: list.width
        height: 20
        anchors.bottom: list.top
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        text: (pagesModel.currentPage) + " / " + pagesModel.rowCount()
    }

    ListView {
        id: list

        //        onCurrentIndexChanged: pagesModel.currentPage = currentIndex
        width: parent.width
        height: 100
        cacheBuffer: 0
        snapMode: ListView.SnapToItem
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        model: pagesModel
        orientation: ListView.Horizontal
        highlightRangeMode: ListView.StrictlyEnforceRange
        spacing: 10
        delegate: Grid {
            rows: 1
            columns: 5
            Repeater {
                model: pagesModel.itemsForPage

                Button {
                    id: chamberButton
                    width: list.width / chambers.currentText
                    height: 100

                    onClicked: {
                        pagesModel.setCurrentPage(buttonText.text)

//                        pagesModel.setTotalItems(chambers.currentText)
                    }
                    Rectangle {
                        width: parent.width * .95
                        height: parent.height * .95
                        anchors.centerIn: parent
                        radius: height * .2
                        color: Qt.rgba(Math.random(), Math.random(),
                                       Math.random(), 1)

                        Text {
                            id: buttonText
                            anchors.centerIn: parent
                            width: parent.width * .5
                            height: parent.height * .5
                            text: nameRole
                        }
                    }
                }
            }
        }
    }
}
