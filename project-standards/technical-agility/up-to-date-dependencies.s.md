# [Standard] Stable and up-to-date dependencies

## Owner: [Xavier Lefèvre](https://github.com/xavierlefevre)

## Description
- The project code dependencies such as NPM packages need to be very regularly updated, the team should check once per sprint.

## Impact
- An old dependency, can become deprecated and not adapt well with new operating systems, browers, development tools, etc.

## Checks
*TBD*

## Bad Examples

### redacted project
- Problem: Cordova has not been updated for several months on the project and one day a developer could not launch the app on an iOS emulator because his new Xcode version had an emulator list descreprency not handled by this old Cordova version, but handled by the new one.
- Loss: 1h30 of debugging + 1h30 of problem solving

## Good Examples
*TBD*
