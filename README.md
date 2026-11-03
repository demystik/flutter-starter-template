# 🎨 Flutter Design System Starter
A production-ready Flutter design system built from scratch — colors,
typography, spacing, components, and dark mode all defined in one place
and used everywhere. No more hardcoded values, no more inconsistent UI.
<br><br>
[![My Skills](https://skillicons.dev/icons?i=flutter,dart,vscode)](https://skillicons.dev)


## 🚀 Features
-   Color palette with a proper neutral scale and semantic colors
-   Typography system with 8 text styles wired into ThemeData
-   Spacing and border radius tokens — no more magic numbers
-   Light & dark theme — one switch, entire app flips
-   Reusable components built on top of tokens: AppButton, AppCard, AppTextField, AppChip
-   Zero hardcoded values anywhere in the UI

## 📂 Folder Structure
    lib/
     ├─ core/
     │   ├─ common/
     │   │   └─ widgets/
     │   │       ├─ app_button.dart
     │   │       ├─ app_card.dart
     │   │       ├─ app_chip.dart
     │   │       └─ app_text_field.dart
     │   └─ config/
     │       └─ theme/
     │           ├─ app_colors.dart
     │           ├─ app_text_styles.dart
     │           ├─ app_spacing.dart
     │           └─ app_theme.dart
     └─ main.dart

## 🎨 Design Tokens

### ✔️ Colors — `app_colors.dart`
Brand colors, a full neutral scale (grey100 → grey900), and semantic
colors for success, warning, and error. One place, entire app.

### ✔️ Typography — `app_text_styles.dart`
8 text styles from `displayLarge` down to `labelMedium`, all wired into
Flutter's `TextTheme`. Change your font in one line.

### ✔️ Spacing & Radius — `app_spacing.dart`
A consistent spacing scale (`xs` → `xxl`) and border radius scale
(`sm` → `full`). No more eyeballing padding values.

### ✔️ Theme — `app_theme.dart`
Wires all tokens into `ThemeData`. Both light and dark themes fully
configured — buttons, inputs, cards, app bar, dividers, snack bars.

## 🧩 Components

| Component | Description |
|---|---|
| `AppButton` | Full-width button with primary, outlined, and ghost variants + loading state |
| `AppCard` | Surface container with consistent shadow, radius, and padding |
| `AppTextField` | Text input with focused, error, and disabled border states |
| `AppChip` | Selectable chip with filled and outlined variants + delete support |

## 🌙 Dark Mode
Because all components reference `Theme.of(context).colorScheme` instead
of hardcoded colors, dark mode works automatically. Just toggle
`ThemeMode.system` in your `MaterialApp` and everything flips.

## 🏁 Getting Started

```bash
git clone https://github.com/demystik/flutter_design_system_starter.git
cd flutter_design_system_starter
flutter pub get
flutter run
```
## 🌙 Testing Dark Mode on MACOS

**System Preferences way:**
In the simulator go to **Settings → Developer → Dark Appearance** and toggle it on.

**Fastest way — Terminal:**
```bash
xcrun simctl ui booted appearance dark
```
And back to light:
```bash
xcrun simctl ui booted appearance light
```
## 📄 License
MIT
