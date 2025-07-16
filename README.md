
# Securx - A Security Analysis Package

[![pub package](https://img.shields.io/pub/v/securx.svg)](https://pub.dev/packages/securx)
[![Maintenance](https://img.shields.io/maintenance/yes/2025)](https://pub.dev/packages/securx/score)



A robust mobile security package designed to enhance application resilience against various threats. This package includes features for device integrity checks, secure communication, mobile privacy, and fraud prevention.

## Features

### Device Integrity
- **Root Detection**: Detects rooted devices to prevent unauthorized modifications.
    - **Severity**: High
    - **Benefits**: Prevents tampering and enhances app security.

- **Emulator Detection**: Identifies if the app runs in an emulator, a common tool for reverse engineering.
    - **Severity**: High
    - **Benefits**: Reduces the risk of reverse engineering and debugging attacks.

- **Debugger Detection**: Identifies debuggers attached to the app.
    - **Severity**: High
    - **Benefits**: Increases resistance to runtime inspection and protects sensitive data.

- **Malicious Root App Detection**: Flags root management apps that can compromise security.
    - **Severity**: Medium
    - **Benefits**: Safeguards user data from root-level threats.

### OS Integrity
- **ADB Wireless/USB Debugging Detection**: Flags if ADB debugging is enabled.
    - **Severity**: Low
    - **Benefits**: Protects against unauthorized debugging and data exposure.

- **Developer Mode Detection**: Identifies if developer mode is active.
    - **Severity**: Low
    - **Benefits**: Minimizes attack surface by disabling additional tools for attackers.

### Secure Communication
- **VPN Detection**: Checks if the app is accessed over a VPN.
    - **Severity**: Low
    - **Benefits**: Provides network security insights.

### Mobile Privacy
- **Screen Capturing Prevention**: Restricts unauthorized screenshots or recordings.
    - **Severity**: Medium
    - **Benefits**: Secures sensitive visual data.

- **Copy-Paste Prevention**: (coming soon) Prevents sensitive data from being copied to the clipboard.
    - **Severity**: Medium
    - **Benefits**: Ensures confidentiality of sensitive information.

- **Screen Sharing Prevention**: Restricts unauthorized screen sharing.
    - **Severity**: Medium
    - **Benefits**: Protects sensitive visual information.

### Mobile Fraud
- **App Cloning/Second Space Detection**: Identifies cloned apps or dual instances to prevent fraud.
    - **Severity**: Medium
    - **Benefits**: Protects against impersonation and unauthorized access.

## Installation

To integrate this package into your project:

```bash
flutter pub add securx
```

## Usage

Here’s an example of how to initialize and use the package in your app:

### Flutter Example

Import the Security Analysis package
```bash
import 'package:securx/securx.dart';
```

Initialize the Security Analysis package
```bash
final _secuxPlugin = Securx(
  applicationID: "com.security.securx",
  initialScreenshotProtection: false,
);

// To control screenshot protection after initialization
_securxPlugin.setScreenshotProtection(enabled: true); // true = restricted
```

## Compatibility

| Feature                             | Android | iOS  | 
| ----------------------------------- | :-----: | :--: | 
| Root / Jailbreak Detection          |   ✅    |   ✅  | 
| Emulator Detection                  |   ✅    |   ✅  | 
| Debugger Detection                  |   ✅    |   ✅  | 
| Malicious Root App Detection        |   ✅    |   ❌  | 
| ADB Debugging Detection             |   ✅    |   ❌  | 
| Developer Mode Detection            |   ✅    |   ❌  | 
| VPN Detection                       |   ✅    |   ✅  | 
| Screen Capturing Prevention         |   ✅    |   ✅  | 
| Screen Share Prevention             |   ✅    |   ✅  | 
| App Cloning/Second Space Detection  |   ✅    |   ❌  | 
<!-- | Copy-Paste Prevention               |   ✅    |   ✅  |  -->


