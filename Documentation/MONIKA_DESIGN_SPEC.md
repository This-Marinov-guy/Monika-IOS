### Monika Design Specification

Version: 1.0
Owner: Design & iOS
Updated: 2025-10-20

---

### Brand & Personality

- **Keywords**: Playful, Warm, Personal, Cheerful, Clean, Premium
- **Purpose**: Help users schedule and send thoughtful gifts (flowers, chocolates, surprises) for birthdays, anniversaries, and special dates.
- **Core Actions**: Schedule reminders, browse suggestions, receive playful nudges, track upcoming events.

---

### Color System

Use an adaptive palette with distinct light/dark themes. Ensure accessible contrast for text and critical UI.

Light Theme

- **Primary**: `#FF69B4` (Hot Pink)
- **Secondary**: `#FFD166` (Sunshine Yellow)
- **Accent**: `#6C63FF` (Lilac Blue)
- **Background**: `#FFF9FB` (Soft rose)
- **Surface**: `#FFFFFF`
- **Text Primary**: `#2D2D2D`
- **Text Secondary**: `#707070`
- **Success**: `#5DD39E`

Dark Theme

- **Primary**: `#FF85C1` (Softer pink)
- **Secondary**: `#FFD97D`
- **Accent**: `#9381FF`
- **Background**: `#1A1A1A`
- **Surface**: `#2B2B2B`
- **Text Primary**: `#FFFFFF`
- **Text Secondary**: `#BDBDBD`
- **Success**: `#67E8A3`

CTA Gradient

- **Primary CTA**: Linear gradient 135° from `#FF69B4` → `#FFD166`

---

### Token Mapping (proposed)

Map the palette into `DesignTokens.Colors` and gradients to keep the app coherent. These names match existing tokens; only values change, plus a few additions.

- `DesignTokens.Colors.primary` → Light `#FF69B4`; Dark `#FF85C1`
- `DesignTokens.Colors.accent` → Light `#6C63FF`; Dark `#9381FF`
- `DesignTokens.Colors.background` → Light `#FFF9FB`; `backgroundDark` → `#1A1A1A`
- `DesignTokens.Colors.surface` → Light `#FFFFFF`; `surfaceDark` → `#2B2B2B`
- `DesignTokens.Colors.textPrimary` → Light `#2D2D2D`; `textPrimaryDark` → `#FFFFFF`
- `DesignTokens.Colors.textSecondary` → Light `#707070`; `textSecondaryDark` → `#BDBDBD`
- `DesignTokens.Colors.success` → Light `#5DD39E`; add `successDark` → `#67E8A3`
- Add `DesignTokens.Colors.secondary` (light `#FFD166`, dark `#FFD97D`)

Gradients (examples)

- `DesignTokens.Gradients.primary` → `[#FF69B4, #6C63FF]`
- `DesignTokens.Gradients.secondary` → `[#FF69B4, #FFD166]` (CTA)
- `DesignTokens.Gradients.backgroundLight` → soft rose to white
- `DesignTokens.Gradients.backgroundDark` → subtle pink/purple haze to dark

Note: Maintain adaptive helpers (`adaptiveTextPrimary`, `adaptiveSurface`, etc.) and update internals to the new palette.

---

### Typography

- **Title/Headers**: Baloo 2 or Poppins, Bold (fallback: SF Pro Rounded Bold)
- **Body**: Inter or SF Pro Rounded, Regular/Medium
- **Buttons**: Poppins SemiBold (fallback: SF Pro Rounded Semibold)
- **Caption**: Inter Light (fallback: SF Pro Text Light)

Sizes (guideline)

- Display: 40–32 bold/black rounded
- Title: 28/24/20 bold/semibold rounded
- Body: 16 regular/medium
- Caption: 12–13

---

### Layout & Key Screens

Home (Dashboard)

- Header: “Hey [Name], ready to make someone smile?” with playful emoji (🎂🎈)
- Upcoming Events: horizontal carousel of cards (birthday, anniversary)
- FAB: + button with primary pink; shadow and bounce on press
- Motive Quote: “A flower today keeps the frown away 🌷”

Add Gift Reminder (flow)

1) Occasion: Birthday 🎂 / Anniversary 💕 / Custom 🎁
2) Select Contact: iOS Contacts integration
3) Gift Type: Flowers, Chocolates, Custom
4) Date Picker: randomize or manual set
5) CTA: rounded gradient button (pink → yellow)

Gift Suggestions

- Grid of ideas with image tiles
- Tags: “Popular”, “Budget”, “Surprise”
- Favorites: heart toggle
- Optional: swipe to reveal “Add to Reminder”

Notifications (tone)

- “Psst… time to sprinkle some joy 💐”
- “Don’t forget — love grows with flowers 🌸”
- “A gentle nudge from Monika 💌”

---

### Theming Architecture (SwiftUI)

Use a theme value type and a manager to switch based on color scheme and user preference. Provide environment objects at the app root.

```swift
import SwiftUI

struct MonikaTheme {
    let primary: Color
    let secondary: Color
    let accent: Color
    let background: Color
    let surface: Color
    let textPrimary: Color
    let textSecondary: Color
    let success: Color
    let ctaGradient: LinearGradient
}

final class ThemeManager: ObservableObject {
    @Published var colorScheme: ColorScheme? = nil // follow system by default

    var light: MonikaTheme {
        MonikaTheme(
            primary: Color(hex: "FF69B4"),
            secondary: Color(hex: "FFD166"),
            accent: Color(hex: "6C63FF"),
            background: Color(hex: "FFF9FB"),
            surface: .white,
            textPrimary: Color(hex: "2D2D2D"),
            textSecondary: Color(hex: "707070"),
            success: Color(hex: "5DD39E"),
            ctaGradient: LinearGradient(colors: [Color(hex: "FF69B4"), Color(hex: "FFD166")], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
    }

    var dark: MonikaTheme {
        MonikaTheme(
            primary: Color(hex: "FF85C1"),
            secondary: Color(hex: "FFD97D"),
            accent: Color(hex: "9381FF"),
            background: Color(hex: "1A1A1A"),
            surface: Color(hex: "2B2B2B"),
            textPrimary: .white,
            textSecondary: Color(hex: "BDBDBD"),
            success: Color(hex: "67E8A3"),
            ctaGradient: LinearGradient(colors: [Color(hex: "FF85C1"), Color(hex: "FFD97D")], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
    }
}
```

Usage in views:

```swift
@Environment(\.colorScheme) private var systemScheme
@EnvironmentObject private var themeManager: ThemeManager

var theme: MonikaTheme { (systemScheme == .dark ? themeManager.dark : themeManager.light) }

var body: some View {
    ZStack {
        theme.background.ignoresSafeArea()
        // ...
        Button("Add Reminder") {}.frame(maxWidth: .infinity, minHeight: 56)
            .background(theme.ctaGradient)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
```

Keep the existing `DesignTokens` as the canonical system. Update token values and keep the adaptive helpers to minimize churn.

---

### Components

Cards

- Rounded 20–24 corner radius
- Light shadow, colored glow variant for hero cards
- Surface uses theme.surface; text uses primary/secondary tokens

Buttons

- Primary: gradient (pink → yellow), 56pt height, 16pt radius, bold rounded font
- Secondary: subtle surface with brand stroke
- Icon Buttons: 48pt square, rounded, colored shadow on press

Inputs

- 56pt height, large touch targets, rounded 12pt, clear affordances

Tabs

- 24pt icons, 80pt tall custom tab bar, gentle haptic on selection

---

### Motion & Interactions

- Button press: subtle bounce (spring)
- Success: short confetti burst
- Sheet transitions: bottom spring pop
- Haptics: light on core actions (add, confirm), medium on errors

Snippet (bounce):

```swift
withAnimation(.spring(response: 0.35, dampingFraction: 0.7, blendDuration: 0.2)) {
    // state toggle
}
```

---

### Iconography & Branding

- Rounded, friendly icons; SF Symbols Rounded acceptable
- Examples: 🎁 gifts, 💐 reminders, ❤️ favorites, 🔔 notifications
- App icon: stylized flower or gift box with pink–yellow gradient
- Splash: animated flower bloom, “Monika” in playful type

---

### Accessibility

- Minimum 44pt touch targets
- Text contrast: AA for body, AAA for small text where possible
- Respect Dynamic Type; avoid text truncation in key flows
- Support VoiceOver labels for interactive elements

---

### Implementation Checklist

- [ ] Update `DesignTokens.Colors` to new palette (light/dark)
- [ ] Add `secondary` and `successDark` tokens
- [ ] Refresh gradient tokens (`primary`, `secondary`, `background*`)
- [ ] Keep adaptive helpers; update internals
- [ ] Update buttons/cards to use new gradients and radii
- [ ] Verify contrast in light/dark across key screens

---

### File Pointers

- Tokens: `Sources/Theme/DesignTokens.swift`
- Global env: `Sources/MonikaSwiftApp.swift` (provides `ThemeManager`)
- Buttons/Cards: `Sources/Components/...`
- Screens: `Sources/Views/...`

---

### Notes

- Keep the “playful premium” tone throughout copy, color, and motion.
- Favor rounded shapes, warm palette, and gentle gradients.
