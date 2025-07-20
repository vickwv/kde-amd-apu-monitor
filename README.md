# KDE System Resource Monitor Widget

A system resource monitor widget for KDE Plasma 6.3+ specifically designed for AMD APUs, providing real-time monitoring of CPU, memory, network, and power consumption.

![KDE Plasma](https://img.shields.io/badge/KDE%20Plasma-6.3+-blue)
![License](https://img.shields.io/badge/License-GPL%202.0+-green)
![Languages](https://img.shields.io/badge/Languages-5-orange)
![Platform](https://img.shields.io/badge/Platform-Linux-lightgrey)
![CPU](https://img.shields.io/badge/CPU-AMD%20APU-red)

## Features

### 🎯 Core Monitoring
- **CPU Monitoring**
  - Real-time CPU usage percentage
  - Current CPU frequency display
  - Temperature monitoring
  - Power consumption tracking (AMD APUs only)
  
- **Memory Monitoring**
  - Memory usage percentage
  - Used/Total memory display
  - Real-time updates

- **Network Monitoring**
  - Upload/Download speeds
  - Automatic unit conversion (B/s, KB/s, MB/s)
  - Real-time network activity

- **Process Information**
  - Top CPU consuming process
  - Top memory consuming process
  - System load averages (1, 5, 15 minutes)

### 🌐 Internationalization
Full support for 5 languages:
- English
- Simplified Chinese (简体中文)
- Traditional Chinese (繁體中文)
- Japanese (日本語)
- Korean (한국어)

Users can select their preferred language in the widget settings or use Auto mode to follow system language.

### 🎨 Design
- Clean and modern interface
- Compact taskbar view with expandable details
- Color-coded indicators for different resource levels
- Smooth animations and transitions
- Follows KDE Plasma theme

## Requirements

### System Requirements
- KDE Plasma 6.3 or higher
- Qt 6.0+
- KSysGuard sensors framework

### Compatibility

**⚠️ Important**: This widget is specifically designed and tested for:
- **Device**: ThinkBook 14+ (2023)
- **CPU**: AMD Ryzen 7 7840HS APU
- **GPU**: AMD Radeon 780M (integrated)

While it may work on other AMD APUs, full functionality (especially power monitoring) is only guaranteed on the tested hardware.

### Software Requirements
- **Operating System**: Linux (tested on Manjaro)
- **Kernel**: Linux 6.0+
- **Desktop Environment**: KDE Plasma 6.3.6
- **Window Manager**: KWin (X11/Wayland)

## Installation

### Quick Install

1. Clone the repository:
```bash
git clone https://github.com/vickwv/kde-amd-apu-monitor.git
cd kde-amd-apu-monitor
```

2. Run the installation script:
```bash
./install.sh
```

3. Add the widget to your panel:
   - Right-click on your panel
   - Select "Add Widgets"
   - Search for "System Resource Monitor"
   - Drag it to your desired panel location

### Manual Installation

If you prefer manual installation:
```bash
# Copy widget files
cp -r plasma-cpu-monitor ~/.local/share/plasma/plasmoids/org.kde.plasma.cpumonitor

# Restart Plasma Shell
kquitapp5 plasmashell && kstart5 plasmashell
```

## Configuration

Right-click on the widget and select "Configure" to access settings:

### Language Settings
- **Auto**: Follow system language
- **Manual Selection**: Choose from 5 supported languages
- Changes take effect immediately

### Update Interval
- Adjustable from 500ms to 5000ms
- Default: 1000ms (1 second)

## Power Monitoring Support

The widget is specifically designed for AMD APU power monitoring:
- Uses AMD PPT (Package Power Tracking) sensors
- Monitors APU power consumption in real-time
- Requires specific sensor support found in AMD APUs

### Hardware Compatibility
- **Tested**: AMD Ryzen 7 7840HS (ThinkBook 14+)
- **May work**: Other AMD 7000 series APUs with similar sensor support
- **Not supported**: Intel CPUs, discrete GPUs, older AMD CPUs without PPT sensors

**Note**: Power monitoring features are hardware-specific and may not function correctly on untested devices.

## Development

### Project Structure
```
kde-amd-apu-monitor/
├── plasma-cpu-monitor/
│   ├── contents/
│   │   ├── ui/
│   │   │   ├── main.qml          # Main widget code
│   │   │   └── config/           # Configuration UI
│   │   └── config/               # Configuration schema
│   ├── translate/                # Translation files
│   │   ├── en/                   # English
│   │   ├── zh_CN/               # Simplified Chinese
│   │   ├── zh_TW/               # Traditional Chinese
│   │   ├── ja/                  # Japanese
│   │   └── ko/                  # Korean
│   └── metadata.json            # Widget metadata
├── install.sh                   # Installation script
├── extract-messages.sh          # Translation extraction script
└── README.md                    # This file
```

### Adding New Translations

1. Extract translatable strings:
```bash
./extract-messages.sh
```

2. Create new translation file in `plasma-cpu-monitor/translate/YOUR_LANG/`

3. Add language option in `ConfigGeneral.qml`

4. Update translations in `main.qml` getTranslations() function

## Troubleshooting

### Widget Not Updating
If the widget doesn't update after installation:
1. Remove the old widget from your panel
2. Re-add it from the widget list
3. The installation script automatically clears caches

### Power Monitoring Not Working
- Ensure your CPU supports power monitoring
- Check available sensors: `sensors | grep -E '(PPT|power)'`
- The widget will fall back to estimation if hardware sensors are unavailable

### Language Not Changing
- Language changes take effect immediately
- If not, try removing and re-adding the widget

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

### Development Guidelines
- Follow KDE coding standards
- Test on multiple screen resolutions
- Ensure translations are complete
- Update documentation for new features

## License

This project is licensed under the GPL-2.0+ License - see the LICENSE file for details.

## Performance

- **CPU Usage**: < 0.5% on modern multi-core processors
- **Memory Footprint**: ~40-60MB depending on features enabled
- **Update Efficiency**: Optimized sensor polling to minimize system impact

## Security & Privacy

- No data collection or telemetry
- All monitoring is performed locally
- No network connections except for monitoring network interfaces
- Open source code for full transparency

## Acknowledgments

- KDE Plasma team for the excellent framework
- Contributors and translators
- AMD and Intel for open sensor documentation
- Open source monitoring tools community

---

**Note**: This widget is specifically designed for AMD Ryzen 7 7840HS APU (ThinkBook 14+) running KDE Plasma 6.3+. Compatibility with other hardware is not guaranteed, especially for power monitoring features.