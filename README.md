# FlexFlex

Create fully customizable popups easier than ever before.

## 🛠 Installation

FlexFlex requires iOS 13 and Xcode 12.

1️⃣ In Xcode go to `File` ➤ `Add Packages...`

2️⃣ In the top right corner, paste `https://github.com/adri567/FlexFlex.git` and press Enter.

3️⃣ Choose `FlexFlex` from the list ➤ `Add Package`

This was easy, or? Now you can use FlexFlex in your project!

## ❤️‍🔥 Example

<p align="center">
<img src="https://user-images.githubusercontent.com/26815443/184192573-fb685bb2-f5e6-4f8f-a0c5-43e25cf3096f.gif" width="300px"></img></img> 
</p>



## 🪛 Usage
<p align="right"> Copy this code ⬇️<p>

```swift
import FlexFlex
```
Create a property to toggle the State to show the popup

```swift
@State private var isPresenting: Bool = false

FlexPopup({
                // Any content
}, presenting: $isPresenting, position: .top, closeOnTap: true)
```
  
## 〽️ Example code from above

```swift
struct ContentView: View {
    @State private var isPresentingTop: Bool = false
    @State private var isPresentingCenter: Bool = false
    @State private var isPresentingBottom: Bool = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(spacing: 40) {
                Button {
                    withAnimation {
                        isPresentingTop.toggle()
                        automaticDismiss()
                    }
                } label: {
                    Text("Top")
                }
                Button {
                    withAnimation {
                        isPresentingCenter.toggle()
                    }
                } label: {
                    Text("Center")
                }
                Button {
                    withAnimation {
                        isPresentingBottom.toggle()
                    }
                } label: {
                    Text("Bottom")
                }
            }
            FlexPopup({
                top
            }, presenting: $isPresentingTop, position: .top, closeOnTap: true)
            FlexPopup({
                center
            }, presenting: $isPresentingCenter, position: .center, closeOnTap: true)
            FlexPopup({
                bottom
            }, presenting: $isPresentingBottom, position: .bottom, closeOnTap: true)
        }
    }
    
    private var bottom: some View {
        VStack {
            Text("Are you sure you want to cancel the contract?")
                .font(.title3)
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
            Button {
                isPresentingBottom.toggle()
            } label: {
                Text("Cancel contract")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
    
    private var center: some View {
        VStack(spacing: 0) {
            Image(systemName: "tropicalstorm")
                .resizable()
                .frame(maxWidth: 100)
                .frame(height: 150)
                .aspectRatio(contentMode: .fill)
                .foregroundColor(.yellow)
            Text("Congratulations!")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical)
                .foregroundColor(.black)
            Text("You found the hidden spiral that gives you infinite power.")
                .font(.title3)
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            Button {
                isPresentingCenter.toggle()
            } label: {
                Text("Collect")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
    
    private var top: some View {
        VStack {
            HStack {
                Image(systemName: "battery.100")
                    .foregroundColor(.green)
                Text("Youre battery is full of charge.")
                    .foregroundColor(.black)
            }
        }
    }
    
    func automaticDismiss() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isPresentingTop.toggle()
        }
    }
    
}  
```


