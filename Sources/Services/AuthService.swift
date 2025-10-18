import Foundation
import Supabase
import Combine

@MainActor
public class AuthService: ObservableObject {
    @Published public var currentUser: User?
    @Published public var isAuthenticated = false
    @Published public var isLoading = false
    @Published public var errorMessage: String?
    
    private var authStateChangeTask: Task<Void, Never>?
    
    public init() {
        Task {
            await checkSession()
            await observeAuthStateChanges()
        }
    }
    
    deinit {
        authStateChangeTask?.cancel()
    }
    
    // MARK: - Session Management
    
    func checkSession() async {
        do {
            let session = try await SupabaseManager.shared.auth.session
            currentUser = session.user
            isAuthenticated = true
        } catch {
            currentUser = nil
            isAuthenticated = false
        }
    }
    
    private func observeAuthStateChanges() async {
        authStateChangeTask = Task {
            for await state in SupabaseManager.shared.auth.authStateChanges {
                guard !Task.isCancelled else { return }
                
                switch state.event {
                case .signedIn, .tokenRefreshed, .userUpdated:
                    currentUser = state.session?.user
                    isAuthenticated = true
                case .signedOut:
                    currentUser = nil
                    isAuthenticated = false
                default:
                    break
                }
            }
        }
    }
    
    // MARK: - Sign Up
    
    func signUp(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await SupabaseManager.shared.auth.signUp(
                email: email,
                password: password
            )
            
            currentUser = response.user
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    // MARK: - Sign In
    
    func signIn(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await SupabaseManager.shared.auth.signIn(
                email: email,
                password: password
            )
            
            currentUser = response.user
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    // MARK: - Sign Out
    
    func signOut() async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await SupabaseManager.shared.auth.signOut()
            currentUser = nil
            isAuthenticated = false
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    // MARK: - Password Recovery
    
    func resetPassword(email: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await SupabaseManager.shared.auth.resetPasswordForEmail(email)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}

