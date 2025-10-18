import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Welcome header
                VStack(spacing: 10) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.green)
                    
                    Text("Welcome!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    if let email = authService.currentUser?.email {
                        Text(email)
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 40)
                
                Spacer()
                
                // Info cards
                VStack(spacing: 15) {
                    InfoCard(
                        icon: "person.circle.fill",
                        title: "Profile",
                        description: "You're successfully authenticated"
                    )
                    
                    InfoCard(
                        icon: "shield.checkered",
                        title: "Secure",
                        description: "Your session is protected by Supabase"
                    )
                    
                    InfoCard(
                        icon: "sparkles",
                        title: "Ready to Build",
                        description: "Start building your amazing app"
                    )
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Profile button
                NavigationLink {
                    ProfileView()
                } label: {
                    HStack {
                        Image(systemName: "person.crop.circle")
                        Text("View Profile")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Home")
        #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
        }
    }
}

struct InfoCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(.blue)
                .frame(width: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthService())
}

