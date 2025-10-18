# 📱 Xcode Setup Instructions

## ✅ Fix Complete!

Your project is now properly configured. Follow these steps in Xcode:

## Step 1: Add Local Package

1. In Xcode, go to **File → Add Package Dependencies...**

2. Click **Add Local...** (bottom left)

3. Navigate to and select: `/Users/vlady/Desktop/monika-swift`
   (The parent folder containing Package.swift)

4. Click **Add Package**

5. Select **MonikaSwiftCore** library

6. Click **Add Package** again

## Step 2: Add Supabase Package

1. Still in **File → Add Package Dependencies...**

2. Paste URL: `https://github.com/supabase/supabase-swift.git`

3. Version: **2.0.0** (or "Up to Next Major")

4. Click **Add Package**

## Step 3: Select Simulator & Run

1. Top toolbar → Select **any iPhone simulator** (e.g., iPhone 15 Pro)

2. Press **⌘+R** to build and run!

## What Was Fixed?

✅ Converted Package.swift to export a library (`MonikaSwiftCore`)  
✅ iOS app now imports the library instead of using symlinks  
✅ Clean separation: all code in `Sources/`, iOS wrapper in `MonikaSwiftiOS/`  
✅ No code duplication - both projects share the same source

## Troubleshooting

**If you still see "Cannot find 'AuthService' in scope":**
- Make sure you added the **local package** (Step 1)
- Clean build folder: Product → Clean Build Folder (⌘+Shift+K)
- Restart Xcode

**If Supabase fails to resolve:**
- Make sure you have network access
- Try removing and re-adding the Supabase package

---

🎉 **You're all set! Happy iOS development!**

