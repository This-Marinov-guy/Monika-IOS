# Monika Swift

A SwiftUI application built with Swift Package Manager and Supabase authentication.

## Features

- Modern SwiftUI interface
- Cross-platform support (macOS 13+, iOS 16+)
- Supabase authentication (email/password, password recovery)
- Session management with auto-restore
- Google Sign-In placeholder (ready for iOS implementation)

## Requirements

- Swift 6.1 or later
- macOS 14+ or iOS 16+
- Xcode 15+ (recommended)
- Supabase account and project

## Setup

### 1. Environment Variables

Create a `.env` file in the root directory (or use the provided `.env.example` as a template):

```bash
cp .env.example .env
```

Then edit `.env` with your Supabase credentials:

```env
SUPABASE_URL=your_supabase_url_here
SUPABASE_ANON_KEY=your_supabase_anon_key_here
```

**Note:** The `.env` file is gitignored to protect your secrets.

### 2. Running the App

#### Option A: Using the run script (loads .env automatically)

```bash
./run.sh
```

#### Option B: Manual run with environment variables

```bash
# Export environment variables
export SUPABASE_URL=your_supabase_url
export SUPABASE_ANON_KEY=your_anon_key

# Run the app
swift run
```

#### Option C: Running in Xcode

1. Open the project:
   ```bash
   xed .
   ```

2. Set environment variables in Xcode:
   - Select the scheme (MonikaSwift) → Edit Scheme
   - Go to Run → Arguments → Environment Variables
   - Add:
     - `SUPABASE_URL` = your Supabase URL
     - `SUPABASE_ANON_KEY` = your Supabase anon key

3. Press ⌘+R to run

## Getting Started

### Building the Project

```bash
swift build
```

### Running the Project

```bash
./run.sh
# or
swift run
```

## Project Structure

```
monika-swift/
├── Package.swift                 # Swift Package Manager configuration
├── .env                          # Environment variables (gitignored)
├── .env.example                  # Template for environment variables
├── run.sh                        # Script to run app with .env loaded
├── Sources/
│   ├── MonikaSwiftApp.swift     # App entry point with @main
│   ├── ContentView.swift        # Main app view with auth handling
│   ├── Configs/
│   │   └── Config.swift         # Configuration (reads from env vars)
│   ├── Clients/
│   │   └── SupabaseClient.swift # Supabase client instance
│   ├── Services/
│   │   └── AuthService.swift    # Authentication service
│   └── Views/
│       ├── Auth/                # Authentication views
│       │   ├── LoginView.swift
│       │   ├── SignUpView.swift
│       │   ├── ForgotPasswordView.swift
│       │   └── AuthContainerView.swift
│       ├── HomeView.swift       # Home screen
│       └── ProfileView.swift    # Profile screen
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
