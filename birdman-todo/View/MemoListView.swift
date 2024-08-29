import SwiftUI

struct MemoListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        List(listViewModel.todos, id: \.id) { todo in
            HStack {
                VStack(alignment: .leading) {
                    Text("id: \(todo.id)")
                    Text("text: " + todo.text)
                }
                
                Spacer()
                
                Button {
                    Task {
                        await listViewModel.delete(id: todo.id)
                        await listViewModel.getWord()
                    }
                } label: {
                    Text("削除")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(24)
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
    MemoListView()
        .environmentObject(ListViewModel())
}
