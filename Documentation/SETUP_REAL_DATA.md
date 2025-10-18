# Load Real Data from Supabase

## 📊 Sample Data SQL

I've created `Database/Seeders/sample_data.sql` with sample data for your user ID: `cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5`

The SQL includes:
- **6 People**: John Doe, Jane Smith, Mike Johnson, Emily Brown, Sarah Wilson, David Lee
- **6 Events**: Birthdays, anniversaries, and holidays with reminders
- **7 Gifts**: Various gift ideas with prices, priorities, and purchase status

## 🚀 How to Load the Data

### Step 1: Run the SQL in Supabase

1. Go to your Supabase project: https://sqvpbhrccjweyedowepf.supabase.co
2. Navigate to **SQL Editor**
3. Copy the contents of `Database/Seeders/sample_data.sql`
4. Paste and click **Run**

**Note:** The SQL uses lowercase values (`birthday`, `anniversary`, `holiday`) to match the Swift enum definitions.

### Step 2: Run the App

The app is now configured to load real data from Supabase!

```bash
# macOS
cd /Users/vlady/Desktop/monika-swift
swift run

# iOS (in Xcode)
# 1. Add local package: /Users/vlady/Desktop/monika-swift
# 2. Add MonikaSwiftCore library
# 3. Build & Run
```

## ✨ What's Working

### People Tab
- ✅ Loads all people from Supabase
- ✅ Search functionality
- ✅ Add new people via form
- ✅ Shows birthdays
- ✅ Empty states

### Gifts Tab  
- ✅ Loads all gifts from Supabase
- ✅ Filter by purchased status
- ✅ Priority badges (Low, Medium, High, Wishlist)
- ✅ Price display
- ✅ Grouped by person

### Calendar Tab
- ✅ Week and Month views
- ✅ Date selection
- ✅ Event markers
- ✅ Add new events

### Profile Tab
- ✅ User info display
- ✅ Dark mode toggle
- ✅ Sign out

## 🔌 API Integration

All views now use ViewModels that fetch data from Supabase:

- `PeopleViewModel` → `PeopleService` → Supabase `people` table
- `EventsViewModel` → `EventsService` → Supabase `events` table
- `GiftsViewModel` → `GiftsService` → Supabase `gifts` table

## 📝 Sample Data Overview

### People (6 total)
- John Doe (Birthday: May 15, 1990)
- Jane Smith (Birthday: Nov 22, 1988)
- Mike Johnson (Birthday: Mar 8, 1995)
- Emily Brown (Birthday: Jul 30, 1992)
- Sarah Wilson (Birthday: Dec 14, 1985)
- David Lee (Birthday: Sep 25, 1993)

### Events (6 total)
- John's Birthday - May 15, 2024
- Jane's Birthday - Nov 22, 2024
- Mike's Birthday - Mar 8, 2024
- Emily's Birthday - Jul 30, 2024
- Anniversary with Sarah - Jun 10, 2024
- Christmas - Dec 25, 2024

### Gifts (7 total)
- Smartwatch for John ($299.99) - High priority, not purchased
- Book Collection for John ($49.99) - Medium priority, purchased
- Necklace for Jane ($159.99) - High priority, not purchased
- Headphones for Mike ($199.99) - Medium priority, not purchased
- Tea Set for Emily ($79.99) - Medium priority, purchased
- Photo Album for Sarah ($39.99) - Low priority, not purchased
- Gaming Console for David ($499.99) - Wishlist, not purchased

## 🎯 Next Steps

1. **Run the SQL** in Supabase to add the sample data
2. **Launch the app** and sign in with your account
3. **Browse the People tab** to see real data loaded
4. **Try adding** a new person or gift
5. **Toggle dark mode** in the Profile tab

Enjoy your planner app with real data! 🎉

