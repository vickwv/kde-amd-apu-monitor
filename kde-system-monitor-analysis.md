# KDE Plasma System Monitor Component Analysis Report

## Overview
Through analyzing system monitoring related components in the `/usr/share/plasma/plasmoids/` directory, I discovered two main approaches for KDE Plasma to retrieve CPU usage data.

## Discovered System Monitor Components

1. **org.kde.plasma.systemmonitor.cpu** - Overall CPU usage monitor
2. **org.kde.plasma.systemmonitor.cpucore** - CPU core monitor
3. **org.kde.plasma.systemmonitor.memory** - Memory monitor
4. **org.kde.plasma.systemmonitor** - General system monitoring framework

## Data Retrieval Methods

### 1. Using KSysGuard Sensors API (New Method)

In newer KDE Plasma versions, system monitor components use the `org.kde.ksysguard.sensors` API:

```qml
import org.kde.ksysguard.sensors 1.0 as Sensors

Sensors.Sensor {
    id: totalSensor
    sensorId: "cpu/all/usage"  // Overall CPU usage
    updateRateLimit: 1000      // Update frequency (milliseconds)
}
```

**Common CPU Sensor IDs:**
- `cpu/all/usage` - Overall CPU usage (percentage)
- `cpu/all/cpuCount` - Number of CPUs
- `cpu/all/coreCount` - Number of CPU cores

**Memory Sensor IDs:**
- `memory/physical/used` - Used physical memory
- `memory/physical/usedPercent` - Memory usage percentage
- `memory/physical/total` - Total physical memory

### 2. Using Plasma5Support DataSource (Compatibility Method)

In some components (like user-defined cpumonitor), Plasma5Support DataSource is used:

```qml
import org.kde.plasma.plasma5support as Plasma5Support

Plasma5Support.DataSource {
    id: dataSource
    engine: "systemmonitor"
    connectedSources: ["cpu/system/TotalLoad"]
    interval: 1000
    
    onNewData: (sourceName, data) => {
        if (sourceName === "cpu/system/TotalLoad") {
            cpuUsage = data.value || 0;
        }
    }
}
```

**DataSource Data Source Names:**
- `cpu/system/TotalLoad` - Total CPU load

## Component Structure

### 1. System Monitor Component Configuration Structure
Each system monitor component typically includes:
- `metadata.json` - Component metadata
- `contents/config/faceproperties` - Defines sensors used and display configuration
- `contents/ui/main.qml` - Main interface file

### 2. faceproperties Configuration Example
```ini
[Config]
chartFace=org.kde.ksysguard.piechart
highPrioritySensorIds=["cpu/all/usage"]
totalSensors=["cpu/all/usage"]
lowPrioritySensorIds=["cpu/all/cpuCount","cpu/all/coreCount"]

[FaceConfig]
rangeAuto=false
rangeFrom=0
rangeTo=100
```

## Key Findings

1. **Two APIs Coexist**: KDE Plasma supports both the new KSysGuard Sensors API and the older Plasma5Support DataSource API.

2. **Sensor ID Formats**:
   - New API uses formats like `cpu/all/usage`
   - Old API uses formats like `cpu/system/TotalLoad`

3. **Face Controller**: New system monitor components use Face Controller pattern, allowing dynamic configuration of display modes (like pie charts, line graphs, etc.).

4. **Update Mechanism**:
   - Sensors API controls update frequency through `updateRateLimit`
   - DataSource controls update interval through `interval` property

## Recommendations

For developing new system monitor components, it's recommended to:
1. Prioritize using KSysGuard Sensors API, as it's the more modern approach
2. Use standard sensor ID formats (like `cpu/all/usage`)
3. Utilize Face Controller pattern to provide flexible display options
4. Consider supporting both compact view and full view