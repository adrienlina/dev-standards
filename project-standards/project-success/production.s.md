# [Standard] Launch in production (each plateform) or Apple agreement asked (if sprint >= 2)

## Owner: [Xavier Lefèvre](https://github.com/xavierlefevre)

## Description
- The project needs to be placed in front of its end users as fast as possible, the team needs to do the necessary for this as soon as the second sprint starts.

## Impact
- Showing a MVP as soon as possible to end users is a mean to avoid as much as possible waste and un-necessary developments (hence spendings) for un-wanted features. The risk to waste a lot of money in developments is much higher than the risk to be repelled by your customer base for a small clean feature.

## Checks
- [ ] Every week, take a "Launch in production" ticket.
- [ ] Create a "In production" ticket in your "Done" columns in order to specify which dev has been launched or not, and keep a trace of it for future "LIP".
- [ ] For micro-services, check each and every API when you launch in production.
- [ ] When developing, always think about the retro-compatibility of your changes in the back-end (versioning) to make sure that people who do not have the last version of the app don't get un-wanted bugs.

## When the final goal is to override an existing app

Replacing the existing app in the stores might be done later in the project, but there are still things to check beforehand:

### Checks

#### Check the `targetSdkVersion` of the existing version

- [ ] You cannot downgrade the `targetSdkVersion`, so your new project needs to have at least the same `targetSdkVersion` as the old one.

N.B.: By default, a React Native project has `22` as its `targetSdkVersion`.

`targetSdkVersion` 23 is for Android 6+ where [permissions are now asked at runtime](http://developer.android.com/training/permissions/requesting.html) and not at installation.

So if the app you're replacing has set 23 as the `targetSdkVersion`, your new app needs to have at least that, and should implement permissions at runtime.

You can use [react-native-permissions](https://github.com/yonahforst/react-native-permissions) to that effect.

#### Use the existing app keystore

You might not be replacing the app yet, but you should already use its keystore for production builds.

## Bad Examples
*TBD*

## Good Examples
*TBD*
