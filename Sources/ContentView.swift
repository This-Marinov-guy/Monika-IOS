import SwiftUI

struct ContentView: View {
    @State private var counter = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Monika Swift!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Counter: \(counter)")
                .font(.title)
                .foregroundColor(.blue)
            
            HStack(spacing: 15) {
                Button(action: {
                    counter -= 1
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title)
                }
                .buttonStyle(.bordered)
                
                Button(action: {
                    counter += 1
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                }
                .buttonStyle(.bordered)
                
                Button(action: {
                    counter = 0
                }) {
                    Text("Reset")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .frame(minWidth: 400, minHeight: 300)
    }
}

#Preview {
    ContentView()
}


