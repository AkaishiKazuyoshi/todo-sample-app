import SwiftUI

struct InputBox: View {
    @State var inputText = ""
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        HStack {
            TextField("Todo", text: $inputText)
                .padding(.leading, 50)

            Button {
                Task {
                    await listViewModel.post(text: inputText)
                    await listViewModel.getWord()
                }
            } label: {
                Text("Todo　登録")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(24)
            .disabled(inputText.isEmpty)
            
            Spacer()
                .frame(width: 20)
        }
        .padding(.top, 50)
    }
}
