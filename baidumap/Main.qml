import QtQuick 2.4
import Ubuntu.Components 1.3
import "WebApi.js" as API
import QtPositioning 5.0

MainView {
    id:  mainScreen

    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "baidumap.liu-xiao-guo"

    property string longitude: "116.3883"
    property string latitude: "39.9289"

    property string kaide_latitude: "39.971375"
    property string kaide_longitude: "116.44785"
    property var converted

    width: units.gu(60)
    height: units.gu(85)

    PositionSource {
        id: me
        active: true
        updateInterval: 1000
        preferredPositioningMethods: PositionSource.AllPositioningMethods
        onPositionChanged: {
            console.log("latitude: " + position.coordinate.latitude + " longitude: " +
                        position.coordinate.longitude);
            console.log(position.coordinate)

            mainScreen.longitude = position.coordinate.longitude;
            mainScreen.latitude = position.coordinate.latitude;

            before.source = API.getStaticMap(longitude, latitude)

            // Do the conversion here
            API.convertCoordinates(longitude, latitude, gotConverted)
        }

        onSourceErrorChanged: {
            console.log("Source error: " + sourceError);
        }
    }


    function gotConverted(o) {
        after.source = API.getStaticMap(o.longitude, o.latitude)
    }

    Page {
        title: i18n.tr("baidumap")

        Column {
            anchors.fill: parent
            spacing: units.gu(2)

            Image {
                id: before
                width: parent.width
                height: parent.height/2                

                Label {
                    text: "Before conversion"
                    fontSize: "large"
                }
            }

            Image {
                id: after
                width: parent.width
                height: parent.height/2

                Label {
                    text: "After conversion"
                    fontSize: "large"
                }
            }
        }

        Component.onCompleted: {
//            API.convertCoordinates(kaide_longitude, kaide_latitude, gotConverted)
        }
    }
}

