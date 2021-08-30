# Native Dialog

A Flutter plugin to trigger native alert and confirm dialogs.

## Description

Native Dialog uses the native UI on each platform to show alert and confirm dialogs.
It automatically uses the localized texts for "OK" and "Cancel" buttons.

## Usage

### Alert dialog

```dart
import 'package:native_dialog/native_dialog.dart';

try {
  await NativeDialog.alert("Oops, something went wrong!");
} on PlatformException catch (error) {
  print(error.message);
}
```

#### Android

<img alt="android-alert" src="https://user-images.githubusercontent.com/2261067/131282061-43a14f2c-0861-4b8f-b52e-9700a1ee5026.gif" height="480">

#### iOS

<img alt="ios-alert" src="https://user-images.githubusercontent.com/2261067/131282077-bd2f59f4-f6bd-4546-ba2b-2cb8794f2049.gif" height="480">

#### Web

<img alt="web-alert" src="https://user-images.githubusercontent.com/2261067/131282770-9c4be2a4-b38c-4b85-b537-2a5e84ed545f.gif" height="480">

### Confirm dialog

```dart
import 'package:native_dialog/native_dialog.dart';

try {
  final confirmed = await NativeDialog.confirm("Do you really want to leave?");
  print(confirmed);
} on PlatformException catch (error) {
  print(error.message);
}
```

#### Android

<img alt="android-confirm" src="https://user-images.githubusercontent.com/2261067/131282073-a85f7851-f28a-4ead-b83d-f01f06a36313.gif" height="480">

#### iOS

<img alt="ios-confirm" src="https://user-images.githubusercontent.com/2261067/131282079-5d79641c-3e7e-44fd-bba5-add22a3ea568.gif" height="480">

#### Web

<img alt="web-confirm" src="https://user-images.githubusercontent.com/2261067/131282084-fc3b1e5d-31bd-4851-8955-d20cea5538a8.gif" height="480">
