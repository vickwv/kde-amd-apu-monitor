#!/bin/bash

# Extract translatable messages from QML files

BASEDIR="plasma-cpu-monitor"
PROJECTNAME="plasma_applet_org.kde.plasma.cpumonitor"

# Extract messages from QML files
xgettext --from-code=UTF-8 \
         --language=JavaScript \
         --keyword=i18n:1 \
         --keyword=i18nc:1c,2 \
         --keyword=i18np:1,2 \
         --keyword=i18ncp:1c,2,3 \
         -o ${BASEDIR}/translate/${PROJECTNAME}.pot \
         `find ${BASEDIR} -name '*.qml'`

# Update header information
sed -i 's/SOME DESCRIPTIVE TITLE/AMD APU Monitor Widget/' ${BASEDIR}/translate/${PROJECTNAME}.pot
sed -i 's/PACKAGE VERSION/1.0/' ${BASEDIR}/translate/${PROJECTNAME}.pot
sed -i 's/PACKAGE/plasma-cpumonitor/' ${BASEDIR}/translate/${PROJECTNAME}.pot

echo "Message extraction complete: ${BASEDIR}/translate/${PROJECTNAME}.pot"