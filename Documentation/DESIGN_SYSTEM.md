# Airbnb-Inspired Design System

## ✨ Overview

Your Monika Swift Planner now uses a comprehensive Airbnb-inspired design system based on the specifications in `design.json`. This ensures visual consistency, professional aesthetics, and a premium user experience.

## 🎨 What Was Updated

### 1. **Color Palette**
Updated to match Airbnb's signature colors:

#### Primary Brand
- **Brand Color**: `#FF5A5F` (Airbnb's signature coral/red)
- **Brand Dark**: `#E0484C`
- **Brand Light**: `#FF7E82`
- **Brand Subtle**: `#FFE8E9`

#### Neutral Palette
- Black: `#222222`
- Gray 900-50: Full range from `#484848` to `#F7F7F7`
- White: `#FFFFFF`

#### Semantic Colors
- Success: `#00A699` (teal)
- Warning: `#FFB400` (amber)
- Error: `#FF5A5F` (matches brand)
- Info: `#007AFF` (iOS blue)

### 2. **Typography** 
iOS-native typography matching Airbnb's style:

```swift
// Large titles
largeTitle: 34pt, bold
title1: 28pt, bold
title2: 22pt, bold
title3: 20pt, semibold

// Body text
headline: 17pt, semibold
body: 17pt, regular
callout: 16pt, regular
subheadline: 15pt, regular

// Small text
footnote: 13pt, regular
caption: 12pt, regular
caption2: 11pt, regular
```

### 3. **Spacing System**
Consistent 4-point grid system:

```swift
xs: 4px
sm: 8px
md: 12px
base: 16px
lg: 24px
xl: 32px
xl2: 40px
xl3: 48px
xl4: 64px

// Component-specific
cardPadding: 16px
sectionPadding: 24px
screenPadding: 24px
listItemPadding: 16px
```

### 4. **Border Radius**
Rounded corners for modern aesthetics:

```swift
sm: 4px
md: 8px
lg: 12px
xl: 16px
xl2: 24px
full: 9999px (pill shape)

// Component-specific
button: 8px
card: 12px
image: 12px
modal: 16px
input: 8px
chip: 20px
```

### 5. **Shadows**
Subtle elevation system:

```swift
small: y: 1px, blur: 2px, opacity: 0.05
medium: y: 2px, blur: 8px, opacity: 0.08
large: y: 4px, blur: 16px, opacity: 0.12
card: y: 2px, blur: 8px, opacity: 0.08
```

### 6. **Component Sizes**
Standard sizes for UI components:

```swift
// Buttons
buttonHeight: 48px
buttonSmallHeight: 36px

// Inputs
inputHeight: 56px
searchBarHeight: 56px

// Navigation
tabBarHeight: 49px
navBarHeight: 44px

// Avatars
avatarSmall: 32px
avatarMedium: 40px
avatarLarge: 64px
avatarXLarge: 96px

// Touch targets
minTouchTarget: 44px (iOS accessibility)
```

### 7. **Icons**
SF Symbols sizing:

```swift
small: 16px
medium: 20px
large: 24px
xlarge: 32px
xxl: 48px (for empty states)
tabBar: 24px
```

### 8. **Animation**
Smooth, natural motion:

```swift
instant: 100ms
fast: 200ms
normal: 300ms
slow: 400ms
verySlow: 500ms
```

## 📱 Component Styles

### Cards
```swift
.cardStyle()
// - 12px border radius
// - White background
// - Subtle shadow (y: 2px, blur: 8px)
```

### Primary Buttons
```swift
.primaryButtonStyle()
// - Height: 48px
// - Background: #FF5A5F
// - Text: White, 17pt semibold
// - Border radius: 8px
// - Horizontal padding: 24px
```

### Secondary Buttons
```swift
.secondaryButtonStyle()
// - Height: 48px
// - Background: White
// - Text: Black, 17pt semibold
// - Border: 1px solid black
// - Border radius: 8px
```

## 🎯 Design Principles

Following Airbnb's design philosophy:

1. **Whitespace**: Generous breathing room for visual clarity
2. **Imagery**: High-quality with rounded corners (12px)
3. **Hierarchy**: Bold titles with subtle supporting text
4. **Consistency**: Uniform spacing, alignment, and components
5. **Minimalism**: Clean, uncluttered interfaces
6. **Gesture-First**: Optimized for touch interactions
7. **Feedback**: Clear visual feedback for all actions

## 🔄 Before & After

### Primary Color
- **Before**: `#FF385C` (slightly more red)
- **After**: `#FF5A5F` (authentic Airbnb coral)

### Typography
- **Before**: Custom sizes (14-57pt range)
- **After**: iOS-native sizes (11-34pt) matching SF Pro

### Spacing
- **Before**: 4-64px scale
- **After**: 4-64px scale + component-specific values

### Shadows
- **Before**: Generic small/medium/large
- **After**: Airbnb-calibrated opacity and blur values

## 📖 Usage Examples

### Using Colors
```swift
Text("Hello")
    .foregroundColor(DesignTokens.Colors.textPrimary)
    .background(DesignTokens.Colors.backgroundSecondary)
```

### Using Typography
```swift
Text("Title")
    .font(DesignTokens.Typography.title2)

Text("Body text")
    .font(DesignTokens.Typography.body)
```

### Using Spacing
```swift
VStack(spacing: DesignTokens.Spacing.lg) {
    // 24px spacing
}
.padding(DesignTokens.Spacing.screenPadding) // 24px padding
```

### Using Component Sizes
```swift
Button("Click me") { }
    .frame(height: DesignTokens.ComponentSize.buttonHeight) // 48px
```

## 🎨 Category & Priority Colors

### Event Categories
- Birthday: `#FF5A5F` (brand)
- Anniversary: `#E0484C` (brand dark)
- Holiday: `#FFB400` (warning)
- Reminder: `#00A699` (success)
- Other: `#717171` (gray 700)

### Gift Priorities
- Low: `#B0B0B0` (gray 500)
- Medium: `#007AFF` (info)
- High: `#FFB400` (warning)
- Wishlist: `#FF5A5F` (brand)

## ✅ What's Consistent Now

- ✅ All colors use Airbnb's palette
- ✅ Typography follows iOS standards
- ✅ Spacing is systematic (4px grid)
- ✅ Shadows are subtle and consistent
- ✅ Border radii create cohesive shapes
- ✅ Component sizes match Airbnb's specs
- ✅ Icons use proper SF Symbols sizing
- ✅ Animations feel smooth and natural

## 🚀 Benefits

1. **Professional Appearance**: Looks like a premium iOS app
2. **Consistency**: Same look and feel everywhere
3. **Maintainability**: Easy to update design system-wide
4. **Scalability**: Add new components using existing tokens
5. **Accessibility**: Meets iOS touch target requirements (44px minimum)
6. **Brand Recognition**: Familiar Airbnb aesthetic

## 📚 Reference

See `design.json` for the complete design specification that this implementation is based on.

---

**Design System Version**: 1.0  
**Based on**: Airbnb iOS Design Language  
**Last Updated**: October 2025

