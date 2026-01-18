import SwiftUI

struct TodaysStepsView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "figure.walk")
                .font(.system(size: 48))
            Text("Today's steps will appear here")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    NavigationStack { TodaysStepsView() }
}
