import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents3
import org.kde.kirigami as Kirigami
import org.kde.ksysguard.sensors 1.0 as Sensors
import org.kde.plasma.plasma5support as P5Support

PlasmoidItem {
    id: root
    
    // Configuration
    property string currentLanguage: plasmoid.configuration.language || "auto"
    
    // Watch for configuration changes
    Connections {
        target: plasmoid.configuration
        function onLanguageChanged() {
            currentLanguage = plasmoid.configuration.language || "auto";
            // Force UI refresh
            Plasmoid.title = i18n("System Resource Monitor");
        }
    }
    
    // Language override function
    function i18n() {
        if (currentLanguage === "auto") {
            return Qt.i18n.apply(null, arguments);
        }
        
        // Manual language selection
        var key = arguments[0];
        var params = Array.prototype.slice.call(arguments, 1);
        
        // This is a simplified approach - in production, you'd load the actual .po files
        var translations = getTranslations();
        var translation = translations[currentLanguage] && translations[currentLanguage][key] || key;
        
        // Handle parameter substitution
        for (var i = 0; i < params.length; i++) {
            translation = translation.replace("%"+(i+1), params[i]);
        }
        
        return translation;
    }
    
    function getTranslations() {
        return {
            "zh_CN": {
                "CPU": "CPU",
                "PWR": "功耗",
                "MEM": "内存",
                "M": "M",
                "MEM:": "内存：",
                "Power: %1": "功耗：%1",
                "Temp: %1": "温度：%1",
                "Unknown": "未知",
                "System Resource Monitor": "系统资源监控",
                "CPU Status": "CPU 状态",
                "CPU Power": "CPU功耗",
                "Memory Usage": "内存使用率",
                "Network Speed": "网络速度",
                "Process Information": "进程信息",
                "Top CPU:": "CPU最高：",
                "Top Memory:": "内存最高：",
                "System Load": "系统负载",
                "(%1 core CPU, recommended load < %2)": "（%1核CPU，建议负载<%2）",
                "1 min": "1分钟",
                "5 min": "5分钟",
                "15 min": "15分钟",
                "GPU": "显卡",
                "GPU Status": "显卡状态"
            },
            "zh_TW": {
                "CPU": "CPU",
                "PWR": "功耗",
                "MEM": "記憶體",
                "M": "M",
                "MEM:": "記憶體：",
                "Power: %1": "功耗：%1",
                "Temp: %1": "溫度：%1",
                "Unknown": "未知",
                "System Resource Monitor": "系統資源監控",
                "CPU Status": "CPU 狀態",
                "CPU Power": "CPU功耗",
                "Memory Usage": "記憶體使用率",
                "Network Speed": "網路速度",
                "Process Information": "程序資訊",
                "Top CPU:": "CPU最高：",
                "Top Memory:": "記憶體最高：",
                "System Load": "系統負載",
                "(%1 core CPU, recommended load < %2)": "（%1核CPU，建議負載<%2）",
                "1 min": "1分鐘",
                "5 min": "5分鐘",
                "15 min": "15分鐘",
                "GPU": "顯卡",
                "GPU Status": "顯卡狀態"
            },
            "ja": {
                "CPU": "CPU",
                "PWR": "電力",
                "MEM": "メモリ",
                "M": "M",
                "MEM:": "メモリ：",
                "Power: %1": "電力：%1",
                "Temp: %1": "温度：%1",
                "Unknown": "不明",
                "System Resource Monitor": "システムリソースモニター",
                "CPU Status": "CPU状態",
                "CPU Power": "CPU電力",
                "Memory Usage": "メモリ使用率",
                "Network Speed": "ネットワーク速度",
                "Process Information": "プロセス情報",
                "Top CPU:": "CPU最高：",
                "Top Memory:": "メモリ最高：",
                "System Load": "システム負荷",
                "(%1 core CPU, recommended load < %2)": "（%1コアCPU、推奨負荷<%2）",
                "1 min": "1分",
                "5 min": "5分",
                "15 min": "15分",
                "GPU": "GPU",
                "GPU Status": "GPU状態"
            },
            "ko": {
                "CPU": "CPU",
                "PWR": "전력",
                "MEM": "메모리",
                "M": "M",
                "MEM:": "메모리:",
                "Power: %1": "전력: %1",
                "Temp: %1": "온도: %1",
                "Unknown": "알 수 없음",
                "System Resource Monitor": "시스템 리소스 모니터",
                "CPU Status": "CPU 상태",
                "CPU Power": "CPU 전력",
                "Memory Usage": "메모리 사용률",
                "Network Speed": "네트워크 속도",
                "Process Information": "프로세스 정보",
                "Top CPU:": "최고 CPU:",
                "Top Memory:": "최고 메모리:",
                "System Load": "시스템 부하",
                "(%1 core CPU, recommended load < %2)": "(%1코어 CPU, 권장 부하<%2)",
                "1 min": "1분",
                "5 min": "5분",
                "15 min": "15분",
                "GPU": "GPU",
                "GPU Status": "GPU 상태"
            },
            "en": {
                "CPU": "CPU",
                "PWR": "PWR",
                "MEM": "MEM",
                "M": "M",
                "MEM:": "MEM:",
                "Power: %1": "Power: %1",
                "Temp: %1": "Temp: %1",
                "Unknown": "Unknown",
                "System Resource Monitor": "System Resource Monitor",
                "CPU Status": "CPU Status",
                "CPU Power": "CPU Power",
                "Memory Usage": "Memory Usage",
                "Network Speed": "Network Speed",
                "Process Information": "Process Information",
                "Top CPU:": "Top CPU:",
                "Top Memory:": "Top Memory:",
                "System Load": "System Load",
                "(%1 core CPU, recommended load < %2)": "(%1 core CPU, recommended load < %2)",
                "1 min": "1 min",
                "5 min": "5 min",
                "15 min": "15 min",
                "GPU": "GPU",
                "GPU Status": "GPU Status"
            }
        };
    }
    
    // Microsoft Fluent Design System - Complete color scheme
    property var fluentColors: {
        // Primary Fluent brand colors
        "primary": "#0078D4",              // Fluent primary blue
        "primary_light": "#40E0FF",        // Light blue
        "primary_dark": "#005A9E",         // Dark blue
        
        // Fluent semantic colors
        "success": "#107C10",              // Communication green
        "warning": "#FF8C00",              // Shared orange  
        "error": "#D13438",                // Communication red
        "info": "#0078D4",                 // Communication blue
        
        // Fluent neutral palette 
        "gray10": "#FAF9F8",               // Neutral gray 10
        "gray20": "#F3F2F1",               // Neutral gray 20
        "gray30": "#EDEBE9",               // Neutral gray 30
        "gray40": "#E1DFDD",               // Neutral gray 40
        "gray50": "#D2D0CE",               // Neutral gray 50
        "gray60": "#C8C6C4",               // Neutral gray 60
        "gray70": "#A19F9D",               // Neutral gray 70
        "gray80": "#605E5C",               // Neutral gray 80
        "gray90": "#323130",               // Neutral gray 90
        "gray100": "#201F1E",              // Neutral gray 100
        
        // Fluent Acrylic backgrounds (强烈的毛玻璃效果)
        "acrylic_cpu": "linear-gradient(135deg, rgba(16, 124, 16, 0.3) 0%, rgba(16, 124, 16, 0.1) 100%)",
        "acrylic_memory": "linear-gradient(135deg, rgba(0, 120, 212, 0.3) 0%, rgba(0, 120, 212, 0.1) 100%)", 
        "acrylic_gpu": "linear-gradient(135deg, rgba(135, 100, 184, 0.3) 0%, rgba(135, 100, 184, 0.1) 100%)",
        "acrylic_power": "linear-gradient(135deg, rgba(255, 140, 0, 0.3) 0%, rgba(255, 140, 0, 0.1) 100%)",
        "acrylic_network": "linear-gradient(135deg, rgba(0, 120, 212, 0.2) 0%, rgba(106, 90, 205, 0.1) 100%)",
        
        // Fluent reveal effects
        "reveal_hover": Qt.rgba(1, 1, 1, 0.1),      // White reveal on hover
        "reveal_press": Qt.rgba(1, 1, 1, 0.05),     // White reveal on press
        
        // Fluent elevation shadows
        "shadow_2": Qt.rgba(0, 0, 0, 0.12),         // 2dp elevation
        "shadow_4": Qt.rgba(0, 0, 0, 0.16),         // 4dp elevation
        "shadow_8": Qt.rgba(0, 0, 0, 0.2),          // 8dp elevation
    }
    
    // Fluent Design helper functions
    function getFluentRadius(size) {
        // Fluent corner radius scale
        if (size <= 32) return 4;
        if (size <= 48) return 6; 
        return 8;
    }
    
    function createFluentAcrylic(gradientString) {
        // Create proper gradient background
        return gradientString;
    }
    
    // Helper function to get status color based on percentage (Fluent)
    function getFluentStatusColor(value, warningThreshold, dangerThreshold) {
        if (value >= dangerThreshold) return fluentColors.error;
        if (value >= warningThreshold) return fluentColors.warning;
        return fluentColors.success;
    }
    
    // Helper function to get temperature color (Fluent style)
    function getFluentTempColor(temp) {
        if (temp > 80) return fluentColors.error;
        if (temp > 65) return fluentColors.warning;
        return fluentColors.success;
    }
    
    // Helper function to create Fluent-style gradient
    function createFluentGradient(parent, startColor, endColor) {
        return Qt.createQmlObject('
            import QtQuick 2.0
            LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(parent.width, parent.height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "' + startColor + '" }
                    GradientStop { position: 1.0; color: "' + endColor + '" }
                }
            }', parent);
    }
    
    // Color scheme for expanded view
    property var colorScheme: {
        "bg_cpu": Qt.rgba(0.06, 0.49, 0.06, 0.15),        // 绿色半透明
        "bg_memory": Qt.rgba(0.0, 0.47, 0.83, 0.15),      // 蓝色半透明
        "bg_gpu": Qt.rgba(0.53, 0.39, 0.72, 0.15),        // 紫色半透明
        "bg_power": Qt.rgba(1.0, 0.55, 0.0, 0.15),        // 橙色半透明
        "bg_network": Qt.rgba(0.0, 0.47, 0.83, 0.12),     // 蓝色半透明
        "bg_process": Qt.rgba(0.2, 0.2, 0.2, 0.15),       // 灰色半透明
        "bg_system": Qt.rgba(0.15, 0.15, 0.15, 0.15),     // 深灰色半透明
        "success": fluentColors.success,
        "warning": fluentColors.warning,
        "danger": fluentColors.error,
        "info": fluentColors.info,
        "download": fluentColors.success,
        "upload": fluentColors.warning,
        "gpu_normal": fluentColors.success,
        "gpu_warning": fluentColors.warning,
        "gpu_danger": fluentColors.error
    }
    
    // Helper function to get status color based on percentage
    function getStatusColor(value, warningThreshold, dangerThreshold) {
        if (value >= dangerThreshold) return colorScheme.danger;
        if (value >= warningThreshold) return colorScheme.warning;
        return colorScheme.success;
    }
    
    // Helper function to get temperature color
    function getTempColor(temp) {
        if (temp > 80) return colorScheme.danger;
        if (temp > 65) return colorScheme.warning;
        return colorScheme.success;
    }

    // Plasmoid properties
    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground
    Plasmoid.title: i18n("System Resource Monitor")
    Plasmoid.icon: "utilities-system-monitor"
    
    switchWidth: Kirigami.Units.gridUnit * 10
    switchHeight: Kirigami.Units.gridUnit * 8
    
    property real cpuUsage: 0.0
    property string cpuText: "CPU: 0%"
    property real cpuTemp: 0.0
    property string cpuTempText: "0°C"
    property real cpuFrequency: 0.0
    property string cpuFreqText: "0 GHz"
    property real cpuPower: 0.0
    property string cpuPowerText: "0 W"
    property string debugInfo: "Waiting..."
    property real memoryUsage: 0.0
    property string memoryText: "MEM: 0%"
    property real memoryUsed: 0.0
    property real memoryTotal: 0.0
    property string memoryDetailText: "0 GB / 0 GB"
    property real downloadSpeed: 0.0
    property real uploadSpeed: 0.0
    property string downloadText: "↓ 0 B/s"
    property string uploadText: "↑ 0 B/s"
    property int networkStaleCounter: 0
    property real lastDownloadSpeed: 0.0
    property real lastUploadSpeed: 0.0
    property string topCpuProcess: ""
    property real topCpuUsage: 0.0
    property string topMemProcess: ""
    property real topMemUsage: 0.0
    property real systemLoad1: 0.0
    property real systemLoad5: 0.0
    property real systemLoad15: 0.0
    property string systemLoadText: "0.00 0.00 0.00"
    property int cpuCoreCount: 4 // Default 4 cores, will be dynamically fetched
    property real gpuUsage: 0.0
    property real gpuFrequency: 0.0
    property string gpuUsageText: "GPU: 0%"
    property string gpuFreqText: "0 MHz"
    property real gpuTemp: 0.0
    property string gpuTempText: "0°C"
    
    // Use KSysGuard Sensors to read CPU usage
    Sensors.Sensor {
        id: cpuSensor
        sensorId: "cpu/all/usage"
        updateRateLimit: 1000
        
        onValueChanged: {
            cpuUsage = value || 0;
            cpuText = "CPU: " + Math.round(cpuUsage) + "%";
        }
    }
    
    // Read CPU temperature (AMD CPU)
    Sensors.Sensor {
        id: cpuTempSensor
        sensorId: "lmsensors/k10temp-pci-00c3/Tctl"
        updateRateLimit: 2000
        enabled: true
        
        onValueChanged: {
            cpuTemp = value || 0;
            cpuTempText = Math.round(cpuTemp) + "°C";
        }
    }
    
    // Fallback temperature sensor attempts
    Timer {
        id: tempFallbackTimer
        interval: 3000
        running: cpuTemp === 0
        repeat: true
        property int attemptIndex: 0
        property var fallbackIds: [
            "lmsensors/k10temp-pci-00c3/temp1",
            "lmsensors/k10temp-pci-00c3/temp1_input",
            "cpu/all/averageTemperature"
        ]
        
        onTriggered: {
            if (attemptIndex < fallbackIds.length && cpuTemp === 0) {
                cpuTempSensor.sensorId = fallbackIds[attemptIndex]
                attemptIndex++
            } else {
                running = false
            }
        }
    }
    
    // Read CPU frequency
    Sensors.Sensor {
        id: cpuFreqSensor
        sensorId: "cpu/all/averageFrequency"
        updateRateLimit: 1000
        enabled: true
        
        onValueChanged: {
            cpuFrequency = value || 0;
            // Convert to GHz
            cpuFreqText = (cpuFrequency / 1000).toFixed(2) + " GHz";
        }
    }
    
    // Fallback frequency sensor
    Timer {
        id: freqFallbackTimer
        interval: 3000
        running: cpuFrequency === 0
        repeat: true
        property int attemptIndex: 0
        property var fallbackIds: [
            "cpu/all/frequency",
            "cpu/cpu0/frequency",
            "lmsensors/coretemp-isa-0000/Core 0"
        ]
        
        onTriggered: {
            if (attemptIndex < fallbackIds.length && cpuFrequency === 0) {
                cpuFreqSensor.sensorId = fallbackIds[attemptIndex]
                attemptIndex++
            } else {
                running = false
            }
        }
    }
    
    // Read CPU power consumption
    Sensors.Sensor {
        id: cpuPowerSensor
        sensorId: "cpu/all/power"
        updateRateLimit: 2000
        enabled: true
        
        onValueChanged: {
            if (value && value > 0) {
                cpuPower = value;
                cpuPowerText = cpuPower.toFixed(1) + " W";
            }
        }
    }
    
    // Fallback power sensors
    Timer {
        id: powerFallbackTimer
        interval: 3000
        running: cpuPower === 0
        repeat: true
        property int attemptIndex: 0
        property var fallbackIds: [
            "lmsensors/amdgpu-pci-c500/PPT",
            "lmsensors/amdgpu-pci-*/PPT",
            "lmsensors/zenpower-pci-*/SVI2_P_SoC",
            "lmsensors/zenpower-pci-*/SVI2_P_Core",
            "lmsensors/fam19h_power-pci-*/power1",
            "cpu/cpu/power",
            "cpu/package/power",
            "power/cpu/power",
            "power/package-0"
        ]
        
        onTriggered: {
            if (attemptIndex < fallbackIds.length && cpuPower === 0) {
                cpuPowerSensor.sensorId = fallbackIds[attemptIndex]
                attemptIndex++
            } else {
                running = false
                // If no sensor found, use estimated value
                if (cpuPower === 0) {
                    powerEstimationTimer.running = true;
                }
            }
        }
    }
    
    // Power estimation timer
    Timer {
        id: powerEstimationTimer
        interval: 2000
        running: false
        repeat: true
        
        onTriggered: {
            // Estimate power based on CPU usage and frequency
            // AMD R7 7840H: TDP 35-54W
            var basePower = 10; // Base power 10W
            var maxPower = 54; // Max TDP 54W
            
            if (cpuFrequency > 0 && cpuUsage >= 0) {
                var freqGHz = cpuFrequency / 1000;
                var freqFactor = Math.min(freqGHz / 5.1, 1.0); // R7 7840H max frequency 5.1GHz
                
                // Estimation formula: base power + (usage * (max power - base power) * frequency factor)
                cpuPower = basePower + (cpuUsage / 100) * (maxPower - basePower) * freqFactor;
                cpuPowerText = cpuPower.toFixed(1) + " W*";
            }
        }
    }
    
    // Read GPU usage
    Sensors.Sensor {
        id: gpuUsageSensor
        sensorId: "lmsensors/amdgpu-pci-6500/gpu_busy_percent"
        updateRateLimit: 1000
        enabled: true
        
        onValueChanged: {
            gpuUsage = value || 0;
            gpuUsageText = "GPU: " + Math.round(gpuUsage) + "%";
        }
    }
    
    // GPU usage fallback sensors
    Timer {
        id: gpuUsageFallbackTimer
        interval: 3000
        running: gpuUsage === 0
        repeat: true
        property int attemptIndex: 0
        property var fallbackIds: [
            "lmsensors/amdgpu-pci-6500/gpu_busy_percent",
            "lmsensors/amdgpu-pci-c500/gpu_busy_percent",
            "lmsensors/amdgpu-pci-*/gpu_busy_percent",
            "gpu/gpu1/usage",
            "gpu/gpu0/usage",
            "gpu/gpu1/coreLoad",
            "gpu/gpu0/coreLoad",
            "gpu/gpu0/memoryLoad",
            "gpu/amdgpu/gpu0/usage"
        ]
        
        onTriggered: {
            if (attemptIndex < fallbackIds.length && gpuUsage === 0) {
                gpuUsageSensor.sensorId = fallbackIds[attemptIndex]
                attemptIndex++
            } else {
                running = false
                // If no sensor found, try reading from command line
                if (gpuUsage === 0) {
                    gpuReadTimer.running = true;
                }
            }
        }
    }
    
    // Read GPU frequency
    Sensors.Sensor {
        id: gpuFreqSensor
        sensorId: "lmsensors/amdgpu-pci-6500/freq1_input"
        updateRateLimit: 1000
        enabled: true
        
        onValueChanged: {
            gpuFrequency = value || 0;
            // Convert MHz to GHz
            gpuFreqText = (gpuFrequency / 1000).toFixed(2) + " GHz";
        }
    }
    
    // GPU frequency fallback sensors
    Timer {
        id: gpuFreqFallbackTimer
        interval: 3000
        running: gpuFrequency === 0
        repeat: true
        property int attemptIndex: 0
        property var fallbackIds: [
            "lmsensors/amdgpu-pci-6500/sclk",
            "lmsensors/amdgpu-pci-c500/freq1_input",
            "lmsensors/amdgpu-pci-*/freq1_input",
            "lmsensors/amdgpu-pci-6500/freq1_input",
            "gpu/gpu1/frequency",
            "gpu/gpu0/frequency",
            "gpu/gpu1/coreFrequency",
            "gpu/gpu0/coreFrequency",
            "gpu/amdgpu/gpu0/coreFrequency"
        ]
        
        onTriggered: {
            if (attemptIndex < fallbackIds.length && gpuFrequency === 0) {
                gpuFreqSensor.sensorId = fallbackIds[attemptIndex]
                attemptIndex++
            } else {
                running = false
                // If no sensor found, try reading from command line
                if (gpuFrequency === 0) {
                    gpuReadTimer.running = true;
                }
            }
        }
    }
    
    // Read GPU temperature
    Sensors.Sensor {
        id: gpuTempSensor
        sensorId: "lmsensors/amdgpu-pci-6500/edge"
        updateRateLimit: 2000
        enabled: true
        
        onValueChanged: {
            gpuTemp = value || 0;
            gpuTempText = Math.round(gpuTemp) + "°C";
        }
    }
    
    // GPU temperature fallback sensors
    Timer {
        id: gpuTempFallbackTimer
        interval: 3000
        running: gpuTemp === 0
        repeat: true
        property int attemptIndex: 0
        property var fallbackIds: [
            "lmsensors/amdgpu-pci-6500/edge",
            "lmsensors/amdgpu-pci-c500/edge",
            "lmsensors/amdgpu-pci-*/edge",
            "lmsensors/amdgpu-pci-6500/temp1_input",
            "lmsensors/amdgpu-pci-c500/temp1_input",
            "lmsensors/amdgpu-pci-*/temp1_input",
            "gpu/gpu1/temperature",
            "gpu/gpu0/temperature",
            "gpu/gpu1/coreTemp",
            "gpu/gpu0/coreTemp",
            "gpu/amdgpu/gpu0/temperature"
        ]
        
        onTriggered: {
            if (attemptIndex < fallbackIds.length && gpuTemp === 0) {
                gpuTempSensor.sensorId = fallbackIds[attemptIndex]
                attemptIndex++
            } else {
                running = false
                // If no sensor found, try reading from command line
                if (gpuTemp === 0) {
                    gpuReadTimer.running = true;
                }
            }
        }
    }
    
    // GPU reading timer - try reading GPU stats from command line
    Timer {
        id: gpuReadTimer
        interval: 2000
        running: true  // Start immediately to get GPU data
        repeat: true
        property string cardNumber: "1"  // Default to card1, will be updated by detection
        
        onTriggered: {
            // Always try to read GPU usage from sysfs
            var gpuUsageCmd = "cat /sys/class/drm/card" + cardNumber + "/device/gpu_busy_percent 2>/dev/null || cat /sys/class/drm/card1/device/gpu_busy_percent 2>/dev/null || cat /sys/class/drm/card0/device/gpu_busy_percent 2>/dev/null";
            processDataSource.connectSource("gpuusage|" + gpuUsageCmd);
            
            // Read GPU frequency - get the active frequency from pp_dpm_sclk
            var gpuFreqCmd = "cat /sys/class/drm/card" + cardNumber + "/device/pp_dpm_sclk 2>/dev/null | grep '*' | awk '{print $2}' | sed 's/Mhz//' || cat /sys/class/drm/card1/device/pp_dpm_sclk 2>/dev/null | grep '*' | awk '{print $2}' | sed 's/Mhz//'";
            processDataSource.connectSource("gpufreq|" + gpuFreqCmd);
            
            // Only read temperature if sensor failed
            if (gpuTemp === 0) {
                var gpuTempCmd = "sensors 2>/dev/null | grep -A2 'amdgpu' | grep 'edge:' | awk '{print $2}' | sed 's/[°C+]//g'";
                processDataSource.connectSource("gputemp|" + gpuTempCmd);
            }
        }
    }
    
    // Read memory usage percentage
    Sensors.Sensor {
        id: memorySensor
        sensorId: "memory/physical/usedPercent"
        updateRateLimit: 2000
        
        onValueChanged: {
            memoryUsage = value || 0;
            memoryText = i18n("MEM:") + " " + Math.round(memoryUsage) + "%";
            updateMemoryDetailText();
        }
    }
    
    // Read used memory
    Sensors.Sensor {
        id: memoryUsedSensor
        sensorId: "memory/physical/used"
        updateRateLimit: 2000
        
        onValueChanged: {
            memoryUsed = value || 0;
            updateMemoryDetailText();
        }
    }
    
    // Read total memory
    Sensors.Sensor {
        id: memoryTotalSensor
        sensorId: "memory/physical/total"
        updateRateLimit: 60000 // Total memory doesn't change, reduce update frequency
        
        onValueChanged: {
            memoryTotal = value || 0;
            updateMemoryDetailText();
        }
    }
    
    // Update memory details
    function updateMemoryDetailText() {
        if (memoryTotal > 0) {
            var usedGB = (memoryUsed / 1024 / 1024 / 1024).toFixed(1);
            var totalGB = (memoryTotal / 1024 / 1024 / 1024).toFixed(1);
            memoryDetailText = usedGB + " / " + totalGB + " GB";
        }
    }
    
    // Read network download speed
    Sensors.Sensor {
        id: downloadSensor
        sensorId: "network/all/download"
        updateRateLimit: 1000
        enabled: true
        
        onValueChanged: {
            downloadSpeed = value || 0;
            downloadText = "↓ " + formatNetworkSpeed(downloadSpeed);
            // Reset stale counter when we get valid data
            if (value > 0) {
                networkStaleCounter = 0;
            }
        }
    }
    
    // Read network upload speed
    Sensors.Sensor {
        id: uploadSensor
        sensorId: "network/all/upload"
        updateRateLimit: 1000
        enabled: true
        
        onValueChanged: {
            uploadSpeed = value || 0;
            uploadText = "↑ " + formatNetworkSpeed(uploadSpeed);
            // Reset stale counter when we get valid data
            if (value > 0) {
                networkStaleCounter = 0;
            }
        }
    }
    
    // Network sensor health monitoring and recovery
    Timer {
        id: networkHealthTimer
        interval: 5000 // Check every 5 seconds
        running: true
        repeat: true
        
        onTriggered: {
            // Check if sensors are stale (no changes for multiple intervals)
            var isStale = false;
            
            // Consider it stale if:
            // 1. Both speeds are exactly 0
            // 2. Both speeds haven't changed at all (could be stuck)
            if ((downloadSpeed === 0 && uploadSpeed === 0) || 
                (downloadSpeed === lastDownloadSpeed && uploadSpeed === lastUploadSpeed)) {
                networkStaleCounter++;
                isStale = true;
            } else {
                networkStaleCounter = 0;
            }
            
            // If stale for more than 6 intervals (30 seconds), try to recover
            if (networkStaleCounter > 6) {
                console.log("Network sensors appear stale, attempting recovery...");
                networkFallbackTimer.forceReconnect = true;
                networkFallbackTimer.running = true;
                networkFallbackTimer.attemptIndex = 0;
                networkStaleCounter = 0;
            }
            
            lastDownloadSpeed = downloadSpeed;
            lastUploadSpeed = uploadSpeed;
        }
    }
    
    // Network sensor fallback with dynamic interface detection
    Timer {
        id: networkFallbackTimer
        interval: 2000
        running: downloadSpeed === 0 && uploadSpeed === 0
        repeat: true
        property int attemptIndex: 0
        property bool forceReconnect: false
        
        // Common network interface names
        property var commonInterfaces: ["wlo1", "wlan0", "wlp3s0", "wlp2s0", "enp2s0", "enp3s0", "eth0", "eno1"]
        
        // Build comprehensive sensor ID list
        property var fallbackDownloadIds: {
            var ids = [
                "network/all/download",
                "network/all/downloadBits",
                "network/all/receivedDataRate"
            ];
            
            // Add common interface-specific sensors
            for (var i = 0; i < commonInterfaces.length; i++) {
                var iface = commonInterfaces[i];
                ids.push("network/" + iface + "/download");
                ids.push("network/" + iface + "/downloadBits");
                ids.push("network/interfaces/" + iface + "/receiver/data");
            }
            
            return ids;
        }
        
        property var fallbackUploadIds: {
            var ids = [
                "network/all/upload",
                "network/all/uploadBits",
                "network/all/sentDataRate"
            ];
            
            // Add common interface-specific sensors
            for (var i = 0; i < commonInterfaces.length; i++) {
                var iface = commonInterfaces[i];
                ids.push("network/" + iface + "/upload");
                ids.push("network/" + iface + "/uploadBits");
                ids.push("network/interfaces/" + iface + "/transmitter/data");
            }
            
            return ids;
        }
        
        onTriggered: {
            if (attemptIndex < fallbackDownloadIds.length) {
                if (downloadSpeed === 0 || forceReconnect) {
                    // Force sensor reconnection by disabling and re-enabling
                    downloadSensor.enabled = false;
                    downloadSensor.sensorId = fallbackDownloadIds[attemptIndex];
                    downloadSensor.enabled = true;
                }
                if ((uploadSpeed === 0 || forceReconnect) && attemptIndex < fallbackUploadIds.length) {
                    // Force sensor reconnection by disabling and re-enabling
                    uploadSensor.enabled = false;
                    uploadSensor.sensorId = fallbackUploadIds[attemptIndex];
                    uploadSensor.enabled = true;
                }
            }
            
            attemptIndex++
            
            // Stop after trying all sensors or if we found working ones
            if (attemptIndex >= fallbackDownloadIds.length || (downloadSpeed > 0 && uploadSpeed > 0 && !forceReconnect)) {
                running = false;
                forceReconnect = false;
            }
        }
    }
    
    // Read system load
    Sensors.Sensor {
        id: loadAvg1Sensor
        sensorId: "os/system/load/average1"
        updateRateLimit: 5000
        
        onValueChanged: {
            systemLoad1 = value || 0;
            updateSystemLoadText();
        }
    }
    
    Sensors.Sensor {
        id: loadAvg5Sensor
        sensorId: "os/system/load/average5"
        updateRateLimit: 5000
        
        onValueChanged: {
            systemLoad5 = value || 0;
            updateSystemLoadText();
        }
    }
    
    Sensors.Sensor {
        id: loadAvg15Sensor
        sensorId: "os/system/load/average15"
        updateRateLimit: 5000
        
        onValueChanged: {
            systemLoad15 = value || 0;
            updateSystemLoadText();
        }
    }
    
    // Update system load text
    function updateSystemLoadText() {
        systemLoadText = systemLoad1.toFixed(2) + " " + 
                        systemLoad5.toFixed(2) + " " + 
                        systemLoad15.toFixed(2);
    }
    
    // Get CPU core count
    Component.onCompleted: {
        // Get CPU core count
        processDataSource.connectSource("cpucount|nproc");
        
        // Detect GPU sensors
        detectGPUSensors();
    }
    
    // Function to detect available GPU sensors
    function detectGPUSensors() {
        // Try to read GPU usage directly from sysfs
        processDataSource.connectSource("gpudetect|ls /sys/class/drm/card*/device/gpu_busy_percent 2>/dev/null | head -1");
    }
    
    // Timer to get TOP process information
    Timer {
        id: processTimer
        interval: 5000 // Update every 5 seconds
        running: true
        repeat: true
        
        onTriggered: {
            updateTopProcesses();
        }
        
        Component.onCompleted: {
            updateTopProcesses();
        }
    }
    
    // Power reading timer - try reading more frequently
    Timer {
        id: powerReadTimer
        interval: 2000 // Update every 2 seconds
        running: true
        repeat: true
        
        onTriggered: {
            // Using cut method is more reliable
            var cmd = "sensors 2>/dev/null | grep 'PPT:' | head -1 | cut -d: -f2 | awk '{print $1}'";
            processDataSource.connectSource("amdpower|" + cmd);
            root.debugInfo = "Executing: " + cmd;
        }
    }
    
    // Helper component to run commands
    P5Support.DataSource {
        id: processDataSource
        engine: "executable"
        connectedSources: []
        
        onNewData: {
            if (sourceName.indexOf("topcpu") !== -1) {
                var output = data["stdout"].trim();
                if (output) {
                    var parts = output.split(" ");
                    if (parts.length >= 2) {
                        root.topCpuProcess = parts[1].split("/").pop(); // Only take process name
                        root.topCpuUsage = parseFloat(parts[0]) || 0;
                    }
                }
            } else if (sourceName.indexOf("topmem") !== -1) {
                var output = data["stdout"].trim();
                if (output) {
                    var parts = output.split(" ");
                    if (parts.length >= 2) {
                        root.topMemProcess = parts[1].split("/").pop(); // Only take process name
                        root.topMemUsage = parseFloat(parts[0]) || 0;
                    }
                }
            } else if (sourceName.indexOf("cpucount") !== -1) {
                var output = data["stdout"].trim();
                if (output) {
                    root.cpuCoreCount = parseInt(output) || 4;
                }
            } else if (sourceName.indexOf("amdpower") !== -1) {
                var output = data["stdout"].trim();
                var exitCode = data["exitCode"];
                var stderr = data["stderr"];
                
                // Update debug information
                root.debugInfo = "Output: '" + output + "'\nExit: " + exitCode;
                if (stderr) root.debugInfo += "\nError: " + stderr;
                
                
                if (output && output.length > 0) {
                    var power = parseFloat(output);
                    root.debugInfo += "\nParsed: " + power;
                    if (!isNaN(power) && power > 0 && power < 200) { // Validate reasonable power range
                        root.cpuPower = power;
                        root.cpuPowerText = power.toFixed(1) + " W";
                        root.debugInfo += "\nSuccess!";
                        // Stop estimation timer
                        powerEstimationTimer.running = false;
                        // Stop fallback sensor attempts
                        powerFallbackTimer.running = false;
                    } else {
                        root.debugInfo += "\nInvalid range!";
                    }
                } else {
                    root.debugInfo += "\nNo output!";
                }
            } else if (sourceName.indexOf("gpuusage") !== -1) {
                var output = data["stdout"].trim();
                if (output) {
                    var usage = parseFloat(output);
                    if (!isNaN(usage) && usage >= 0 && usage <= 100) {
                        root.gpuUsage = usage;
                        root.gpuUsageText = "GPU: " + Math.round(usage) + "%";
                        // Stop fallback attempts
                        gpuUsageFallbackTimer.running = false;
                    }
                }
            } else if (sourceName.indexOf("gpufreq") !== -1) {
                var output = data["stdout"].trim();
                if (output) {
                    var freq = parseFloat(output);
                    if (!isNaN(freq) && freq > 0) {
                        root.gpuFrequency = freq;
                        // Convert MHz to GHz
                        root.gpuFreqText = (freq / 1000).toFixed(2) + " GHz";
                        // Stop fallback attempts
                        gpuFreqFallbackTimer.running = false;
                    }
                }
            } else if (sourceName.indexOf("gputemp") !== -1) {
                var output = data["stdout"].trim();
                if (output) {
                    var temp = parseFloat(output);
                    if (!isNaN(temp) && temp > 0 && temp < 150) {
                        root.gpuTemp = temp;
                        root.gpuTempText = Math.round(temp) + "°C";
                        // Stop fallback attempts
                        gpuTempFallbackTimer.running = false;
                    }
                }
            } else if (sourceName.indexOf("gpudetect") !== -1) {
                var output = data["stdout"].trim();
                if (output) {
                    console.log("GPU device found at: " + output);
                    // Extract card number from path
                    var cardMatch = output.match(/card(\d+)/);
                    if (cardMatch) {
                        var cardNum = cardMatch[1];
                        // Update the GPU usage command to use the detected card
                        gpuReadTimer.cardNumber = cardNum;
                    }
                }
            }
            disconnectSource(sourceName);
        }
    }
    
    function updateTopProcesses() {
        // Get process with highest CPU usage
        processDataSource.connectSource("topcpu|ps aux --sort=-pcpu | awk 'NR==2 {print $3, $11}'");
        // Get process with highest memory usage
        processDataSource.connectSource("topmem|ps aux --sort=-pmem | awk 'NR==2 {print $4, $11}'");
        // Get AMD GPU power (PPT) - keep this to ensure reading during initialization
        processDataSource.connectSource("amdpower|sensors 2>/dev/null | grep 'PPT:' | head -1 | cut -d: -f2 | awk '{print $1}'");
    }
    
    // Format network speed function
    function formatNetworkSpeed(speedValue) {
        // Input value is bytes/s
        var bytesPerSecond = speedValue || 0;
        
        // Always show at least KB/s
        if (bytesPerSecond < 1024) {
            return "0.0 KB/s";
        } else if (bytesPerSecond < 1024 * 1024) {
            return (bytesPerSecond / 1024).toFixed(1) + " KB/s";
        } else if (bytesPerSecond < 1024 * 1024 * 1024) {
            return (bytesPerSecond / (1024 * 1024)).toFixed(1) + " MB/s";
        } else {
            return (bytesPerSecond / (1024 * 1024 * 1024)).toFixed(1) + " GB/s";
        }
    }
    
    // Compact network speed format for panel display
    function formatCompactNetworkSpeed(speedValue) {
        var bytesPerSecond = speedValue || 0;
        
        // Always show at least K (KB/s)
        if (bytesPerSecond < 1024) {
            return "0K";
        } else if (bytesPerSecond < 1024 * 1024) {
            return (bytesPerSecond / 1024).toFixed(0) + "K";
        } else if (bytesPerSecond < 1024 * 1024 * 1024) {
            var mbps = bytesPerSecond / (1024 * 1024);
            return mbps < 10 ? mbps.toFixed(1) + "M" : Math.round(mbps) + "M";
        } else {
            return (bytesPerSecond / (1024 * 1024 * 1024)).toFixed(1) + "G";
        }
    }
    
    // Compact representation (panel icon)
    compactRepresentation: Item {
        // 超紧凑布局
        Layout.minimumWidth: (plasmoid.formFactor === PlasmaCore.Types.Vertical) ? 30 : 230
        Layout.minimumHeight: (plasmoid.formFactor === PlasmaCore.Types.Vertical) ? 280 : 36
        Layout.preferredWidth: (plasmoid.formFactor === PlasmaCore.Types.Vertical) ? 48 : 250
        Layout.preferredHeight: (plasmoid.formFactor === PlasmaCore.Types.Vertical) ? 320 : 36
        
        // Choose layout based on panel orientation
        Loader {
            anchors.fill: parent
            sourceComponent: (plasmoid.formFactor === PlasmaCore.Types.Vertical) ? verticalLayout : horizontalLayout
        }
        
        // Horizontal layout (for horizontal panels)
        Component {
            id: horizontalLayout
            RowLayout {
                anchors.fill: parent
                anchors.margins: 0
                spacing: -2  // 更紧凑的负间距
                
                // CPU card - 超紧凑
                Rectangle {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 42
                    Layout.minimumWidth: 38
                    
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Qt.rgba(0.06, 0.49, 0.06, 0.25) }
                        GradientStop { position: 1.0; color: Qt.rgba(0.06, 0.49, 0.06, 0.1) }
                    }
                    radius: getFluentRadius(height)
                    border.width: 1
                    border.color: fluentColors.gray40
                    
                    // Fluent reveal effect on hover
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        
                        Rectangle {
                            anchors.fill: parent
                            color: parent.containsMouse ? fluentColors.reveal_hover : "transparent"
                            radius: parent.radius
                        }
                    }
                    
                    Column {
                        anchors.centerIn: parent
                        spacing: -1
                        
                        PlasmaComponents3.Label {
                            text: Math.round(cpuUsage) + "%"
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 11
                            font.weight: Font.DemiBold
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        
                        PlasmaComponents3.Label {
                            text: cpuFrequency > 0 ? (cpuFrequency / 1000).toFixed(1) + "G" : "--G"
                            color: fluentColors.success
                            font.pixelSize: 8
                            font.weight: Font.Medium
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
                
                // Power card - 超紧凑
                Rectangle {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 42
                    Layout.minimumWidth: 38
                    
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Qt.rgba(1.0, 0.55, 0.0, 0.25) }
                        GradientStop { position: 1.0; color: Qt.rgba(1.0, 0.55, 0.0, 0.1) }
                    }
                    radius: getFluentRadius(height)
                    border.width: 1
                    border.color: fluentColors.gray40
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        
                        Rectangle {
                            anchors.fill: parent
                            color: parent.containsMouse ? fluentColors.reveal_hover : "transparent"
                            radius: parent.radius
                        }
                        
                        PlasmaComponents3.ToolTip {
                            visible: parent.containsMouse
                            text: i18n("Power: %1", cpuPower > 0 ? cpuPower.toFixed(1) + " W" : i18n("Unknown")) + "\n" +
                                  i18n("Temp: %1", cpuTempText) + "\n" + 
                                  "TDP: 35-54W"
                        }
                    }
                    
                    Column {
                        anchors.centerIn: parent
                        spacing: -1
                        
                        PlasmaComponents3.Label {
                            text: cpuPower > 0 ? Math.round(cpuPower) + "W" : "--W"
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 11
                            font.weight: Font.DemiBold
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        
                        PlasmaComponents3.Label {
                            text: Math.round(cpuTemp) + "°"
                            color: getFluentTempColor(cpuTemp)
                            font.pixelSize: 8
                            font.weight: Font.Medium
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
                
                // Memory card - 超紧凑
                Rectangle {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 42
                    Layout.minimumWidth: 38
                    
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Qt.rgba(0.0, 0.47, 0.83, 0.25) }
                        GradientStop { position: 1.0; color: Qt.rgba(0.0, 0.47, 0.83, 0.1) }
                    }
                    radius: getFluentRadius(height)
                    border.width: 1
                    border.color: fluentColors.gray40
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        
                        Rectangle {
                            anchors.fill: parent
                            color: parent.containsMouse ? fluentColors.reveal_hover : "transparent"
                            radius: parent.radius
                        }
                    }
                    
                    Column {
                        anchors.centerIn: parent
                        spacing: -1
                        
                        PlasmaComponents3.Label {
                            text: Math.round(memoryUsage) + "%"
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 11
                            font.weight: Font.DemiBold
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        
                        PlasmaComponents3.Label {
                            text: memoryTotal > 0 ? (memoryUsed / 1024 / 1024 / 1024).toFixed(1) + "G" : "--G"
                            color: fluentColors.info
                            font.pixelSize: 8
                            font.weight: Font.Medium
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
                
                // GPU card - 超紧凑
                Rectangle {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 42
                    Layout.minimumWidth: 38
                    
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Qt.rgba(0.53, 0.39, 0.72, 0.25) }
                        GradientStop { position: 1.0; color: Qt.rgba(0.53, 0.39, 0.72, 0.1) }
                    }
                    radius: getFluentRadius(height)
                    border.width: 1
                    border.color: fluentColors.gray40
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        
                        Rectangle {
                            anchors.fill: parent
                            color: parent.containsMouse ? fluentColors.reveal_hover : "transparent"
                            radius: parent.radius
                        }
                        
                        PlasmaComponents3.ToolTip {
                            visible: parent.containsMouse
                            text: i18n("GPU") + ": " + Math.round(gpuUsage) + "%\n" +
                                  "Freq: " + (gpuFrequency > 0 ? (gpuFrequency / 1000).toFixed(1) + "GHz" : "N/A") + "\n" +
                                  "Temp: " + gpuTempText
                        }
                    }
                    
                    Column {
                        anchors.centerIn: parent
                        spacing: -1
                        
                        PlasmaComponents3.Label {
                            text: Math.round(gpuUsage) + "%"
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 11
                            font.weight: Font.DemiBold
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        
                        PlasmaComponents3.Label {
                            text: Math.round(gpuTemp) + "°"
                            color: getFluentTempColor(gpuTemp)
                            font.pixelSize: 8
                            font.weight: Font.Medium
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
                
                // Network card - 优化布局
                Rectangle {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 48
                    Layout.minimumWidth: 44
                    
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Qt.rgba(0.0, 0.47, 0.83, 0.2) }
                        GradientStop { position: 1.0; color: Qt.rgba(0.42, 0.35, 0.80, 0.1) }
                    }
                    radius: getFluentRadius(height)
                    border.width: 1
                    border.color: fluentColors.gray40
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        
                        Rectangle {
                            anchors.fill: parent
                            color: parent.containsMouse ? fluentColors.reveal_hover : "transparent"
                            radius: parent.radius
                        }
                        
                        PlasmaComponents3.ToolTip {
                            visible: parent.containsMouse
                            text: "Download: " + formatNetworkSpeed(downloadSpeed) + "\nUpload: " + formatNetworkSpeed(uploadSpeed)
                        }
                    }
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 1
                        spacing: 1
                        
                        // 左侧箭头列 - 固定宽度
                        Column {
                            Layout.preferredWidth: 12
                            Layout.minimumWidth: 12
                            Layout.alignment: Qt.AlignVCenter
                            spacing: -1
                            
                            PlasmaComponents3.Label {
                                text: "↓"
                                color: fluentColors.success
                                font.pixelSize: 10
                                font.weight: Font.Bold
                                anchors.right: parent.right
                            }
                            
                            PlasmaComponents3.Label {
                                text: "↑"
                                color: fluentColors.warning
                                font.pixelSize: 10
                                font.weight: Font.Bold
                                anchors.right: parent.right
                            }
                        }
                        
                        // 右侧数值列 - 弹性宽度
                        Column {
                            Layout.fillWidth: true
                            Layout.minimumWidth: 32  // 为数字变大预留空间
                            Layout.alignment: Qt.AlignVCenter
                            spacing: -1
                            
                            PlasmaComponents3.Label {
                                text: formatCompactNetworkSpeed(downloadSpeed)
                                color: fluentColors.success
                                font.pixelSize: 10
                                font.weight: Font.Medium
                                horizontalAlignment: Text.AlignHCenter
                                width: parent.width
                            }
                            
                            PlasmaComponents3.Label {
                                text: formatCompactNetworkSpeed(uploadSpeed)
                                color: fluentColors.warning
                                font.pixelSize: 10
                                font.weight: Font.Medium
                                horizontalAlignment: Text.AlignHCenter
                                width: parent.width
                            }
                        }
                    }
                }
            }
        }
        
        // Vertical layout
        Component {
            id: verticalLayout
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 2
                spacing: 2
                
                // CPU usage
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: colorScheme.bg_cpu
                    border.color: Qt.rgba(1, 1, 1, 0.2)
                    border.width: 1
                    radius: 6
                    
                    Rectangle {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.margins: 1
                        width: parent.width * (cpuUsage / 100)
                        color: getStatusColor(cpuUsage, 50, 80)
                        radius: 1
                    }
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 2
                        spacing: 4
                        
                        PlasmaComponents3.Label {
                            text: i18n("CPU")
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 9
                        }
                        
                        PlasmaComponents3.Label {
                            Layout.fillWidth: true
                            text: Math.round(cpuUsage) + "%"
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 9
                            font.bold: true
                            horizontalAlignment: Text.AlignCenter
                        }
                        
                        PlasmaComponents3.Label {
                            text: cpuTempText
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 8
                            opacity: 0.8
                        }
                    }
                }
                
                // CPU power
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: colorScheme.bg_power
                    border.color: Qt.rgba(1, 1, 1, 0.2)
                    border.width: 1
                    radius: 6
                    
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 1
                        color: colorScheme.bg_power
                        radius: 1
                    }
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 2
                        spacing: 4
                        
                        PlasmaComponents3.Label {
                            text: i18n("PWR")
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 9
                        }
                        
                        PlasmaComponents3.Label {
                            Layout.fillWidth: true
                            text: cpuPower > 0 ? cpuPower.toFixed(1) + "W" : "--W"
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 9
                            font.bold: true
                            horizontalAlignment: Text.AlignCenter
                        }
                    }
                }
                
                // Memory row
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: colorScheme.bg_memory
                    border.color: Qt.rgba(1, 1, 1, 0.2)
                    border.width: 1
                    radius: 6
                    
                    Rectangle {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.margins: 1
                        width: parent.width * (memoryUsage / 100)
                        color: getStatusColor(memoryUsage, 50, 80)
                        radius: 1
                    }
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 2
                        spacing: 4
                        
                        PlasmaComponents3.Label {
                            text: i18n("MEM")
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 9
                        }
                        
                        PlasmaComponents3.Label {
                            Layout.fillWidth: true
                            text: Math.round(memoryUsage) + "%"
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 9
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
                
                // GPU row
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: colorScheme.bg_gpu
                    border.color: Qt.rgba(1, 1, 1, 0.2)
                    border.width: 1
                    radius: 6
                    
                    Rectangle {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.margins: 1
                        width: parent.width * (gpuUsage / 100)
                        color: gpuUsage < 50 ? colorScheme.gpu_normal : gpuUsage < 80 ? colorScheme.gpu_warning : colorScheme.gpu_danger
                        radius: 1
                    }
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 2
                        spacing: 4
                        
                        PlasmaComponents3.Label {
                            text: i18n("GPU")
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 9
                        }
                        
                        PlasmaComponents3.Label {
                            Layout.fillWidth: true
                            text: Math.round(gpuUsage) + "%"
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 9
                            font.bold: true
                            horizontalAlignment: Text.AlignCenter
                        }
                        
                        PlasmaComponents3.Label {
                            text: gpuFrequency > 0 ? (gpuFrequency / 1000).toFixed(1) + "GHz" : "--"
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 8
                            opacity: 0.8
                        }
                    }
                }
                
                // Network row
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: colorScheme.bg_network
                    border.color: Qt.rgba(1, 1, 1, 0.2)
                    border.width: 1
                    radius: 6
                    
                    Column {
                        anchors.fill: parent
                        anchors.margins: 2
                        spacing: 0
                        
                        PlasmaComponents3.Label {
                            width: parent.width
                            text: downloadText
                            color: colorScheme.download
                            font.pixelSize: 10
                            font.bold: true
                            horizontalAlignment: Text.AlignCenter
                            elide: Text.ElideRight
                        }
                        
                        PlasmaComponents3.Label {
                            width: parent.width
                            text: uploadText
                            color: colorScheme.upload
                            font.pixelSize: 10
                            font.bold: true
                            horizontalAlignment: Text.AlignCenter
                            elide: Text.ElideRight
                        }
                    }
                }
            }
        }
        
        MouseArea {
            anchors.fill: parent
            onClicked: root.expanded = !root.expanded
        }
    }
    
    // Full representation (expanded view)
    fullRepresentation: Item {
        Layout.minimumWidth: 300
        Layout.minimumHeight: 400
        Layout.preferredWidth: 350
        Layout.preferredHeight: 500
        
        PlasmaComponents3.ScrollView {
            id: scrollView
            anchors.fill: parent
            anchors.margins: 10
            contentWidth: availableWidth
            
            ColumnLayout {
                width: scrollView.availableWidth
                spacing: 4
            
            Kirigami.Heading {
                level: 3
                text: i18n("System Resource Monitor")
                Layout.alignment: Qt.AlignHCenter
            }
            
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 4
            }
            
            // CPU information section
            PlasmaComponents3.Label {
                text: i18n("CPU Status")
                color: Kirigami.Theme.textColor
                font.pixelSize: 12
                opacity: 0.8
            }
            
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 32
                color: colorScheme.bg_cpu
                radius: 8
                border.width: 1
                border.color: Qt.rgba(1, 1, 1, 0.1)
                
                Rectangle {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 2
                    width: parent.width * (cpuUsage / 100)
                    color: getStatusColor(cpuUsage, 50, 80)
                    radius: 4
                }
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 4
                    
                    PlasmaComponents3.Label {
                        Layout.fillWidth: true
                        text: Math.round(cpuUsage) + "%"
                        color: Kirigami.Theme.textColor
                        font.pixelSize: 14
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                    }
                    
                    PlasmaComponents3.Label {
                        text: cpuFreqText
                        color: Kirigami.Theme.textColor
                        font.pixelSize: 11
                        opacity: 0.9
                    }
                }
            }
            
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 4
            }
            
            // CPU power section
            PlasmaComponents3.Label {
                text: i18n("CPU Power")
                color: Kirigami.Theme.textColor
                font.pixelSize: 12
                opacity: 0.8
            }
            
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 32
                color: colorScheme.bg_power
                radius: 8
                border.width: 1
                border.color: Qt.rgba(1, 1, 1, 0.1)
                
                Rectangle {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 2
                    width: parent.width * Math.min(cpuPower / 54, 1.0) // 54W is TDP limit
                    color: cpuPower < 25 ? colorScheme.success : cpuPower < 45 ? colorScheme.warning : colorScheme.danger
                    radius: 4
                }
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 4
                    
                    PlasmaComponents3.Label {
                        Layout.fillWidth: true
                        text: cpuPower > 0 ? cpuPower.toFixed(1) + " W" : "-- W"
                        color: Kirigami.Theme.textColor
                        font.pixelSize: 14
                        font.bold: true
                        horizontalAlignment: Text.AlignCenter
                    }
                    
                    PlasmaComponents3.Label {
                        text: "/ 54W"
                        color: Kirigami.Theme.textColor
                        font.pixelSize: 11
                        opacity: 0.7
                    }
                    
                    PlasmaComponents3.Label {
                        text: "•"
                        color: Kirigami.Theme.textColor
                        font.pixelSize: 11
                        opacity: 0.5
                    }
                    
                    PlasmaComponents3.Label {
                        text: cpuTempText
                        color: getTempColor(cpuTemp)
                        font.pixelSize: 11
                        opacity: 0.9
                    }
                }
            }
            
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 4
            }
            
            // Memory usage section
            PlasmaComponents3.Label {
                text: i18n("Memory Usage")
                color: Kirigami.Theme.textColor
                font.pixelSize: 12
                opacity: 0.8
            }
            
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 32
                color: colorScheme.bg_memory
                radius: 8
                border.width: 1
                border.color: Qt.rgba(1, 1, 1, 0.1)
                
                Rectangle {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 2
                    width: parent.width * (memoryUsage / 100)
                    color: getStatusColor(memoryUsage, 50, 80)
                    radius: 4
                }
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 4
                    
                    PlasmaComponents3.Label {
                        Layout.fillWidth: true
                        text: Math.round(memoryUsage) + "%"
                        color: Kirigami.Theme.textColor
                        font.pixelSize: 14
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                    }
                    
                    PlasmaComponents3.Label {
                        text: memoryDetailText
                        color: Kirigami.Theme.textColor
                        font.pixelSize: 11
                        opacity: 0.9
                    }
                }
            }
            
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 4
            }
            
            // GPU usage section
            PlasmaComponents3.Label {
                text: i18n("GPU Status")
                color: Kirigami.Theme.textColor
                font.pixelSize: 12
                opacity: 0.8
            }
            
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 32
                color: colorScheme.bg_gpu
                radius: 8
                border.width: 1
                border.color: Qt.rgba(1, 1, 1, 0.1)
                
                Rectangle {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 2
                    width: parent.width * (gpuUsage / 100)
                    color: gpuUsage < 50 ? colorScheme.gpu_normal : gpuUsage < 80 ? colorScheme.gpu_warning : colorScheme.gpu_danger
                    radius: 4
                }
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 4
                    
                    PlasmaComponents3.Label {
                        Layout.fillWidth: true
                        text: Math.round(gpuUsage) + "%"
                        color: Kirigami.Theme.textColor
                        font.pixelSize: 14
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                    }
                    
                    PlasmaComponents3.Label {
                        text: gpuFrequency > 0 ? (gpuFrequency / 1000).toFixed(2) + " GHz" : "-- GHz"
                        color: Kirigami.Theme.textColor
                        font.pixelSize: 11
                        opacity: 0.9
                    }
                    
                    PlasmaComponents3.Label {
                        text: "•"
                        color: Kirigami.Theme.textColor
                        font.pixelSize: 11
                        opacity: 0.5
                    }
                    
                    PlasmaComponents3.Label {
                        text: gpuTempText
                        color: getTempColor(gpuTemp)
                        font.pixelSize: 11
                        opacity: 0.9
                    }
                }
            }
            
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 4
            }
            
            // Network speed section
            PlasmaComponents3.Label {
                text: i18n("Network Speed")
                color: Kirigami.Theme.textColor
                font.pixelSize: 12
                opacity: 0.8
            }
            
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 32
                color: colorScheme.bg_network
                radius: 8
                border.width: 1
                border.color: Qt.rgba(1, 1, 1, 0.1)
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 4
                    spacing: 10
                    
                    PlasmaComponents3.Label {
                        Layout.fillWidth: true
                        text: downloadText
                        color: colorScheme.download
                        font.pixelSize: 12
                        font.bold: true
                        horizontalAlignment: Text.AlignCenter
                    }
                    
                    Rectangle {
                        width: 1
                        height: parent.height - 8
                        color: Kirigami.Theme.textColor
                        opacity: 0.3
                    }
                    
                    PlasmaComponents3.Label {
                        Layout.fillWidth: true
                        text: uploadText
                        color: colorScheme.upload
                        font.pixelSize: 12
                        font.bold: true
                        horizontalAlignment: Text.AlignCenter
                    }
                }
            }
            
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 4
            }
            
            
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 4
            }
            
            // Process information section
            PlasmaComponents3.Label {
                text: i18n("Process Information")
                color: Kirigami.Theme.textColor
                font.pixelSize: 12
                opacity: 0.8
            }
            
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                color: colorScheme.bg_process
                radius: 8
                border.width: 1
                border.color: Qt.rgba(1, 1, 1, 0.1)
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 4
                    spacing: 2
                    
                    RowLayout {
                        Layout.fillWidth: true
                        
                        PlasmaComponents3.Label {
                            text: i18n("Top CPU:")
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 10
                            opacity: 0.8
                        }
                        
                        PlasmaComponents3.Label {
                            Layout.fillWidth: true
                            text: topCpuProcess || "N/A"
                            color: colorScheme.warning
                            font.pixelSize: 11
                            font.bold: true
                            elide: Text.ElideRight
                        }
                        
                        PlasmaComponents3.Label {
                            text: topCpuUsage.toFixed(1) + "%"
                            color: colorScheme.warning
                            font.pixelSize: 10
                        }
                    }
                    
                    RowLayout {
                        Layout.fillWidth: true
                        
                        PlasmaComponents3.Label {
                            text: i18n("Top Memory:")
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 10
                            opacity: 0.8
                        }
                        
                        PlasmaComponents3.Label {
                            Layout.fillWidth: true
                            text: topMemProcess || "N/A"
                            color: colorScheme.info
                            font.pixelSize: 11
                            font.bold: true
                            elide: Text.ElideRight
                        }
                        
                        PlasmaComponents3.Label {
                            text: topMemUsage.toFixed(1) + "%"
                            color: colorScheme.info
                            font.pixelSize: 10
                        }
                    }
                }
            }
            
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 4
            }
            
            // System load section
            RowLayout {
                Layout.fillWidth: true
                
                PlasmaComponents3.Label {
                    text: i18n("System Load")
                    color: Kirigami.Theme.textColor
                    font.pixelSize: 12
                    opacity: 0.8
                }
                
                PlasmaComponents3.Label {
                    Layout.fillWidth: true
                    text: i18n("(%1 core CPU, recommended load < %2)", cpuCoreCount, cpuCoreCount)
                    color: Kirigami.Theme.textColor
                    font.pixelSize: 10
                    opacity: 0.6
                    horizontalAlignment: Text.AlignRight
                }
            }
            
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                color: colorScheme.bg_system
                radius: 8
                border.width: 1
                border.color: Qt.rgba(1, 1, 1, 0.1)
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 6
                    spacing: 2
                    
                    // Load bar chart
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 4
                        
                        // 1 minute load
                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            
                            Rectangle {
                                anchors.bottom: parent.bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.7
                                height: parent.height * Math.min(systemLoad1 / cpuCoreCount, 1.0)
                                color: systemLoad1 > cpuCoreCount ? colorScheme.danger : systemLoad1 > cpuCoreCount * 0.7 ? colorScheme.warning : colorScheme.success
                                radius: 4
                            }
                            
                            PlasmaComponents3.Label {
                                anchors.centerIn: parent
                                text: systemLoad1.toFixed(2)
                                color: Kirigami.Theme.textColor
                                font.pixelSize: 10
                                font.bold: true
                            }
                        }
                        
                        // 5 minute load
                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            
                            Rectangle {
                                anchors.bottom: parent.bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.7
                                height: parent.height * Math.min(systemLoad5 / cpuCoreCount, 1.0)
                                color: systemLoad5 > cpuCoreCount ? colorScheme.danger : systemLoad5 > cpuCoreCount * 0.7 ? colorScheme.warning : colorScheme.success
                                radius: 4
                            }
                            
                            PlasmaComponents3.Label {
                                anchors.centerIn: parent
                                text: systemLoad5.toFixed(2)
                                color: Kirigami.Theme.textColor
                                font.pixelSize: 10
                                font.bold: true
                            }
                        }
                        
                        // 15 minute load
                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            
                            Rectangle {
                                anchors.bottom: parent.bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.7
                                height: parent.height * Math.min(systemLoad15 / cpuCoreCount, 1.0)
                                color: systemLoad15 > cpuCoreCount ? colorScheme.danger : systemLoad15 > cpuCoreCount * 0.7 ? colorScheme.warning : colorScheme.success
                                radius: 4
                            }
                            
                            PlasmaComponents3.Label {
                                anchors.centerIn: parent
                                text: systemLoad15.toFixed(2)
                                color: Kirigami.Theme.textColor
                                font.pixelSize: 10
                                font.bold: true
                            }
                        }
                    }
                    
                    // Time labels
                    RowLayout {
                        Layout.fillWidth: true
                        
                        PlasmaComponents3.Label {
                            Layout.fillWidth: true
                            text: i18n("1 min")
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 9
                            horizontalAlignment: Text.AlignHCenter
                            opacity: 0.7
                        }
                        
                        PlasmaComponents3.Label {
                            Layout.fillWidth: true
                            text: i18n("5 min")
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 9
                            horizontalAlignment: Text.AlignHCenter
                            opacity: 0.7
                        }
                        
                        PlasmaComponents3.Label {
                            Layout.fillWidth: true
                            text: i18n("15 min")
                            color: Kirigami.Theme.textColor
                            font.pixelSize: 9
                            horizontalAlignment: Text.AlignHCenter
                            opacity: 0.7
                        }
                    }
                }
            }
            
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 8
            }
            
            PlasmaComponents3.Label {
                text: i18n("System Resource Monitor")
                Layout.alignment: Qt.AlignHCenter
                color: Kirigami.Theme.textColor
                font.pixelSize: 10
                opacity: 0.8
            }
            
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 4
            }
        }
    }
}
}