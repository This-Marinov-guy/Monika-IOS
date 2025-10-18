# Monika Swift

A beautiful SwiftUI planner app with Supabase backend for tracking important dates, people, events, and gifts.

## Features

- 🎨 Modern Airbnb-inspired design with light/dark mode
- 📅 Calendar views (weekly & monthly)
- 👥 People management with birthdays
- 🎉 Event tracking with categories and reminders
- 🎁 Gift ideas with priority levels
- 🔐 Supabase authentication
- ☁️ Cloud sync across devices

## Requirements

- Swift 6.1 or later
- **iOS**: iOS 16+ (use MonikaSwiftiOS project)
- **macOS**: macOS 14+ (use Package.swift)
- Xcode 15+ (recommended)
- Supabase account and project

## Setup

### 1. Environment Variables

The `.env` file already exists with your Supabase credentials. The app will automatically load them.

### 2. Database Setup

Run the SQL schema in your Supabase project:

1. Go to your Supabase project dashboard
2. Navigate to SQL Editor
3. Copy and paste the contents of `supabase_schema.sql`
4. Run the query

This creates the `people`, `events`, and `gifts` tables with Row Level Security.

## Getting Started

### For iOS Development 📱

```bash
cd MonikaSwiftiOS
open MonikaSwiftiOS.xcodeproj
```

**In Xcode:**
1. **Add Supabase Package** (first time only):
   - File → Add Package Dependencies
   - URL: `https://github.com/supabase/supabase-swift.git`
   - Version: `2.0.0` or "Up to Next Major"
   - Click "Add Package"

2. **Select iOS Simulator**: Choose any iPhone from the device selector

3. **Run**: Press ⌘+R

📖 **Detailed instructions:** See [QUICK_START_IOS.md](QUICK_START_IOS.md)

### For macOS Development 💻

```bash
# Run with environment variables loaded
./run.sh

# Or open Package.swift in Xcode
xed .
```

## Project Structure

```
monika-swift/
├── Package.swift                    # SPM configuration (macOS)
├── MonikaSwiftiOS/                  # iOS Xcode project
│   ├── MonikaSwiftiOS.xcodeproj    # Open this for iOS development
│   └── MonikaSwiftiOS/
│       ├── MonikaSwiftiOSApp.swift # iOS app entry point
│       └── [symlinks to Sources/]   # All code symlinked (no duplication)
├── Sources/                         # Main codebase (shared by both)
│   ├── Models/                     # Data models (Person, Event, Gift)
│   ├── Services/                   # Supabase services
│   ├── Theme/                      # Design system & components
│   ├── Components/                 # Reusable UI components
│   ├── Views/                      # SwiftUI views
│   └── Configs/                    # Configuration
├── supabase_schema.sql             # Database schema
├── .env                            # Supabase credentials (gitignored)
└── README.md
```

## Authentication Flow

1. **Welcome Screen**: Users see options to sign up or log in
2. **Sign Up**: Create account with email/password (6+ characters required)
3. **Login**: Sign in with existing credentials
4. **Forgot Password**: Reset password via email
5. **Home**: Welcome screen with user info
6. **Profile**: View profile and sign out

## Security

- ✅ Supabase keys stored in `.env` file (gitignored)
- ✅ Environment variables used for configuration
- ✅ Fallback values only for development (update `Config.swift` to remove for production)
- ⚠️ Never commit `.env` file or hardcoded secrets

## Learn More

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Supabase Documentation](https://supabase.com/docs)
- [Swift Package Manager](https://swift.org/package-manager/)

---

Happy coding! 🚀
