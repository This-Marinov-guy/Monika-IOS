import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authService: AuthService
    @State private var showingAuth = false
    
    var body: some View {
        Group {
            if authService.isAuthenticated {
                HomeView()
            } else {
                WelcomeView(showingAuth: $showingAuth)
            }
        }
        .sheet(isPresented: $showingAuth) {
            AuthContainerView()
        }
    }
}

struct WelcomeView: View {
    @Binding var showingAuth: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Logo/Icon
            Image(systemName: "sparkles.rectangle.stack.fill")
                .font(.system(size: 100))
                .foregroundColor(.blue)
            
            // Title
            VStack(spacing: 10) {
                Text("Monika Swift")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Welcome to your app")
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Auth buttons
            VStack(spacing: 15) {
                Button {
                    showingAuth = true
                } label: {
                    Text("Get Started")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button {
                    showingAuth = true
                } label: {
                    Text("I already have an account")
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
        .frame(minWidth: 400, minHeight: 500)
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthService())
}


