#!/bin/sh
autogenid="$(date +%s%3N)"
mkdir -p /data/adb/modules/INCPMPLETE-"$autogenid"/opengapps-extracted
mkdir -p /data/adb/modules/INCPMPLETE-"$autogenid"/system
chcon -hR 'u:object_r:system_file:s0' /data/adb/modules/INCPMPLETE-"$autogenid"/system
cat >/data/adb/modules/INCPMPLETE-"$autogenid"/module.prop << END
id=INCOMPLETE-$autogenid
name=INCOMPLETE
version=$autogenid
versionCode=$autogenid
author=auto-generated-$autogenid
description=This module is incomplete. Please remove it.
END
echo "Extracting Open Gapps."
unzip "$1" -d /data/adb/modules/INCPMPLETE-"$autogenid"/opengapps-extracted >/dev/null
echo "Done."
for type in Core GApps; do
	echo "Extracting packages of type $type. This may take up to several minutes."
	mkdir -p /data/adb/modules/INCPMPLETE-"$autogenid"/opengapps-extracted/"$type"/extracted-packages
	for i in /data/adb/modules/INCPMPLETE-"$autogenid"/opengapps-extracted/"$type"/*.tar.*; do
		/data/adb/modules/INCPMPLETE-"$autogenid"/opengapps-extracted/busybox-* tar -xf "$i" -C /data/adb/modules/INCPMPLETE-"$autogenid"/opengapps-extracted/"$type"/extracted-packages
	done
	echo "Done."
	echo "Installing packages of type $type."
	for i in /data/adb/modules/INCPMPLETE-"$autogenid"/opengapps-extracted/"$type"/extracted-packages/*; do
		if [ "$(basename "$i" | cut -c 1-18)" == "setupwizardtablet-" -a "$TABLET" != "1" ]; then
			continue
		fi
		for j in "$i"/*; do
			mkdir -p /data/adb/modules/INCPMPLETE-"$autogenid"/opengapps-extracted/"$type"/merged/"$(basename "$j")"
			cp -r "$j"/* /data/adb/modules/INCPMPLETE-"$autogenid"/opengapps-extracted/"$type"/merged/"$(basename "$j")"
		done
	done
	chcon -hR 'u:object_r:system_file:s0' /data/adb/modules/INCPMPLETE-"$autogenid"/opengapps-extracted/"$type"/merged
	cp -r /data/adb/modules/INCPMPLETE-"$autogenid"/opengapps-extracted/"$type"/merged/common/* /data/adb/modules/INCPMPLETE-"$autogenid"/system
	cp -r /data/adb/modules/INCPMPLETE-"$autogenid"/opengapps-extracted/"$type"/merged/nodpi/* /data/adb/modules/INCPMPLETE-"$autogenid"/system
	echo "Done."
done
echo "Finalizing."
chcon -hR 'u:object_r:system_file:s0' /data/adb/modules/INCPMPLETE-"$autogenid"/system
mv /data/adb/modules/INCPMPLETE-"$autogenid" /data/adb/modules/opengapps-"$autogenid"
cat >/data/adb/modules/opengapps-"$autogenid"/module.prop << END
id=opengapps-$autogenid
name=Open GApps
version=$autogenid
versionCode=$autogenid
author=auto-generated-$autogenid
description=Systemless Open GApps
END
echo "Done."
echo "Installation finished. Please reboot your phone."
