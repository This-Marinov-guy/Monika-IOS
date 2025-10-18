# Monika Swift iOS App

This is the iOS app wrapper for Monika Swift planner.

## How to Run

1. **Open the project in Xcode:**
   ```bash
   open MonikaSwiftiOS.xcodeproj
   ```

2. **Add Supabase Package Dependency:**
   - In Xcode, go to File → Add Package Dependencies
   - Enter: `https://github.com/supabase/supabase-swift.git`
   - Version: 2.0.0 or later
   - Click "Add Package"

3. **Select iOS Simulator:**
   - At the top of Xcode, click on the scheme selector
   - Choose an iOS simulator (e.g., iPhone 15 Pro)

4. **Build and Run:**
   - Press ⌘+R or click the Play button
   - The app will launch in the iOS simulator

## Project Structure

- `MonikaSwiftiOSApp.swift` - iOS app entry point
- All other files are symlinked from `../Sources/` to avoid duplication
- The core code lives in the parent `Sources/` directory

## Troubleshooting

If you get build errors:
1. Make sure Supabase package is added as a dependency
2. Check that your development team is set in Signing & Capabilities
3. Clean build folder (⌘+Shift+K) and rebuild

## Environment Variables

The app uses Supabase credentials from `Sources/Configs/Config.swift`.
Make sure your `.env` file is configured in the parent directory.

