# magisk-opengapps
Install Open Gapps rootlessly as a Magisk module.
### Usage
```
sam0230@Sam0230-macOS:~/Downloads/magisk-opengapps-main$ adb push magisk-opengapps.sh ../open_gapps-arm-10.0-super-20210610.zip
sam0230@Sam0230-macOS:~/Downloads/magisk-opengapps-main$ adb shell su -lMc sh /sdcard/magisk-opengapps.sh /sdcard/open_gapps-arm-10.0-super-20210610.zip
Extracting Open Gapps.
Done.
Extracting packages of type Core. This may take up to several minutes.
Done.
Installing packages of type Core.
Done.
Extracting packages of type GApps. This may take up to several minutes.
Done.
Installing packages of type GApps.
Done.
Finalizing.
Done.
Installation finished. Please reboot your phone.
sam0230@Sam0230-macOS:~/Downloads/magisk-opengapps-main$ 
```
