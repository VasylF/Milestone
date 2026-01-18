import SwiftUI

struct GoalsView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "target")
                .font(.system(size: 48))
            Text("Your goals will appear here")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    NavigationStack { GoalsView() }
}
