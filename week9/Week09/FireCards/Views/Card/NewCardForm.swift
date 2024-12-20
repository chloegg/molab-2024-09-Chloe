import SwiftUI

struct NewCardForm: View {
  @State var question: String = ""
  @State var answer: String = ""
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var cardListViewModel: CardListViewModel

  var body: some View {
    VStack(alignment: .center, spacing: 30) {
      VStack(alignment: .leading, spacing: 10) {
        Text("Question")
          .foregroundColor(.gray)
        TextField("Enter the question", text: $question)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }
      VStack(alignment: .leading, spacing: 10) {
        Text("Answer")
          .foregroundColor(.gray)
        TextField("Enter the answer", text: $answer)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }

      Button(action: addCard) {
        Text("Add New Card")
          .foregroundColor(.blue)
      }
      Spacer()
    }
    .padding(EdgeInsets(top: 80, leading: 40, bottom: 0, trailing: 40))
  }

  private func addCard() {
    // 1
    let card = Card(question: question, answer: answer)
    // 2
    cardListViewModel.add(card)
    // 3
    presentationMode.wrappedValue.dismiss()
  }
}

struct NewCardForm_Previews: PreviewProvider {
  static var previews: some View {
    NewCardForm(cardListViewModel: CardListViewModel())
  }
}
