import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.core 2.0 as PlasmaCore

Kirigami.FormLayout {
    id: page
    
    property alias cfg_language: languageComboBox.currentValue
    property alias cfg_updateInterval: updateIntervalSpinBox.value
    
    ComboBox {
        id: languageComboBox
        Kirigami.FormData.label: i18n("Language:")
        textRole: "text"
        valueRole: "value"
        
        model: ListModel {
            ListElement { text: "Auto (System Default)"; value: "auto" }
            ListElement { text: "English"; value: "en" }
            ListElement { text: "简体中文"; value: "zh_CN" }
            ListElement { text: "繁體中文"; value: "zh_TW" }
            ListElement { text: "日本語"; value: "ja" }
            ListElement { text: "한국어"; value: "ko" }
        }
        
        Component.onCompleted: {
            for (var i = 0; i < model.count; i++) {
                if (model.get(i).value === plasmoid.configuration.language) {
                    currentIndex = i;
                    break;
                }
            }
        }
    }
    
    SpinBox {
        id: updateIntervalSpinBox
        Kirigami.FormData.label: i18n("Update interval:")
        from: 500
        to: 5000
        stepSize: 100
        value: plasmoid.configuration.updateInterval
        
        textFromValue: function(value) {
            return i18n("%1 ms", value)
        }
    }
    
    Item {
        Kirigami.FormData.isSection: true
    }
    
    Label {
        text: i18n("Language changes will take effect after restarting the widget")
        font.italic: true
        opacity: 0.7
    }
}