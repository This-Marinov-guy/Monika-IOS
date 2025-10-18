import Foundation

enum Config {
    static var supabaseURL: URL {
        if let urlString = ProcessInfo.processInfo.environment["SUPABASE_URL"],
           let url = URL(string: urlString) {
            return url
        }
        
        // Fallback to default value if environment variable is not set
        // WARNING: Replace with your actual URL or set SUPABASE_URL environment variable
        guard let url = URL(string: "https://sqvpbhrccjweyedowepf.supabase.co") else {
            fatalError("Invalid Supabase URL")
        }
        return url
    }
    
    static var supabaseAnonKey: String {
        if let key = ProcessInfo.processInfo.environment["SUPABASE_ANON_KEY"] {
            return key
        }
        
        // Fallback to default value if environment variable is not set
        // WARNING: Replace with your actual key or set SUPABASE_ANON_KEY environment variable
        return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNxdnBiaHJjY2p3ZXllZG93ZXBmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA2MzUwMDQsImV4cCI6MjA3NjIxMTAwNH0.Bn7UL1Yq12GkTilzqfs9LSeEB1xGFsfDiUm8M5BdFs0"
    }
}

