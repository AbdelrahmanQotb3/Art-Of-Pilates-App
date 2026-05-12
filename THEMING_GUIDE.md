# App Theming Guide

This document explains how to use the centralized theme system implemented in the Art of Pilates app.

## Overview

The app now uses a centralized theming system defined in `lib/app/core/theme/app_theme.dart`. This ensures consistent styling across the entire application and makes it easy to update the theme globally.

## Theme Configuration

### Color Palette
All colors are defined in `lib/app/core/util/app_colors.dart`:
- **Primary**: `#7776A8` (Purple) - Main brand color
- **Secondary**: `#CACCCC4` (Beige) - Secondary accent
- **Accent**: `#3E453A` (Dark Green) - Text and UI elements
- **Background**: `#F3F2F0` (Light Beige) - Scaffold background
- **White**: `#FFFFFF`
- **Black**: `#000000`
- **Red**: Error color

### Text Styles
The theme includes predefined text styles accessible via `Theme.of(context).textTheme`:

- `displayLarge` - 32sp, bold
- `displayMedium` - 28sp, bold
- `displaySmall` - 24sp, bold
- `headlineMedium` - 22sp, semi-bold
- `headlineSmall` - 20sp, semi-bold
- `titleLarge` - 18sp, semi-bold (AppBar titles)
- `titleMedium` - 16sp, medium
- `titleSmall` - 14sp, medium
- `bodyLarge` - 16sp, regular (body text)
- `bodyMedium` - 14sp, regular
- `bodySmall` - 12sp, regular
- `labelLarge` - 14sp, semi-bold (button labels)
- `labelMedium` - 12sp, semi-bold
- `labelSmall` - 10sp, semi-bold

## Usage Examples

### Using Theme Colors

```dart
import 'package:flutter/material.dart';

// Using primary color
Container(
  color: Theme.of(context).primaryColor,
  child: Text('Themed Container'),
)

// Using colors from color scheme
Text(
  'Error Text',
  style: TextStyle(color: Theme.of(context).colorScheme.error),
)
```

### Using Text Styles

```dart
// Using predefined text styles
Text(
  'Large Title',
  style: Theme.of(context).textTheme.displayLarge,
)

Text(
  'Regular Body Text',
  style: Theme.of(context).textTheme.bodyMedium,
)

Text(
  'Small Label',
  style: Theme.of(context).textTheme.labelSmall,
)
```

### Using Button Themes

Buttons automatically use the theme:

```dart
// Elevated button - automatically uses primary color
ElevatedButton(
  onPressed: () {},
  child: const Text('Submit'),
)

// Text button - automatically uses primary color
TextButton(
  onPressed: () {},
  child: const Text('Cancel'),
)

// Outlined button - automatically uses primary color
OutlinedButton(
  onPressed: () {},
  child: const Text('Options'),
)
```

### TextField with Theme

TextFields automatically use the theme's InputDecorationTheme:

```dart
TextField(
  decoration: InputDecoration(
    hintText: 'Enter your email',
    label: Text('Email'),
  ),
)
```

### AppBar with Theme

AppBars automatically use the theme:

```dart
AppBar(
  title: Text('Screen Title'),
  // Automatically uses primary color and white text
)
```

### Using ColorScheme

For advanced use cases, access the color scheme:

```dart
final colorScheme = Theme.of(context).colorScheme;

Container(
  color: colorScheme.secondary,
  child: Text(
    'Secondary Color Container',
    style: TextStyle(color: colorScheme.onSecondary),
  ),
)
```

## Responsive Sizing with ScreenUtil

All sizing is responsive using `flutter_screenutil`:

```dart
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container(
  width: 100.w,    // Width relative to screen width
  height: 50.h,    // Height relative to screen height
  padding: EdgeInsets.all(16.w),
)

Text(
  'Responsive Text',
  style: TextStyle(fontSize: 14.sp), // Size relative to screen
)
```

## Component Themes

### Card Theme
```dart
Card(
  child: ListTile(
    title: Text('Card Title'),
  ),
)
// Automatically: white background, elevation 2, rounded corners
```

### Dialog Theme
```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Dialog Title'),
    content: Text('Dialog Content'),
  ),
)
// Automatically: white background, elevation 8, rounded corners
```

### SnackBar Theme
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Success!')),
)
// Automatically: dark green background, white text
```

### BottomNavigationBar Theme
```dart
BottomNavigationBar(
  items: [...],
)
// Automatically: white background, primary selected color, accent unselected
```

## Best Practices

1. **Always use theme colors instead of hardcoded colors:**
   ```dart
   // ❌ Bad
   Text('Text', style: TextStyle(color: Color(0xff7776A8)))
   
   // ✅ Good
   Text('Text', style: TextStyle(color: Theme.of(context).primaryColor))
   ```

2. **Use text styles from the theme:**
   ```dart
   // ❌ Bad
   Text('Title', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
   
   // ✅ Good
   Text('Title', style: Theme.of(context).textTheme.headlineSmall)
   ```

3. **Use ColorScheme for semantic colors:**
   ```dart
   // ❌ Bad
   Text('Error', style: TextStyle(color: AppColors.redColor))
   
   // ✅ Good
   Text('Error', style: TextStyle(color: Theme.of(context).colorScheme.error))
   ```

4. **Use ScreenUtil for responsive sizing:**
   ```dart
   // ❌ Bad
   SizedBox(height: 16)
   
   // ✅ Good
   SizedBox(height: 16.h)
   ```

## Updating the Theme

To update the theme globally:

1. Modify colors in `lib/app/core/util/app_colors.dart`
2. Update theme properties in `lib/app/core/theme/app_theme.dart`
3. The changes will apply across the entire app

Example: To change the primary color:

```dart
// In app_colors.dart
static const Color primary = Color(0xffNEWCOLOR);
```

The change will automatically propagate to all buttons, AppBars, and other components using `Theme.of(context).primaryColor`.

## File Structure

```
lib/
├── app/
│   ├── core/
│   │   ├── theme/
│   │   │   └── app_theme.dart          # Theme configuration
│   │   └── util/
│   │       └── app_colors.dart         # Color definitions
│   └── ...
├── main.dart                            # Theme applied here
└── ...
```

## Future Enhancements

- Add dark theme support
- Add theme customization options
- Add animation theme properties
- Add custom widget themes
