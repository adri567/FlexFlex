# FlexFlex

Create fully customizable popups easier than ever before.

## 🛠 Installation

FlexFlex requires iOS 14 and Xcode 12.

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
Button {
print("Hello, world!")
} label: {
Text("Press me")
}
.buttonStyle(.plain)            // When you use a button inside the popup, make sure to use buttonStyle(.plain). Otherwise the popup won't show up.

}, presenting: $isPresenting)
```

You can also use the third parameter to dismiss the popup when tapping outside of the popup.

```swift
FlexPopup({
Button {
print("Hello, world!")
} label: {
Text("Press me")
}
.buttonStyle(.plain)
}, presenting: $isPresenting, closeOnTap: true)         // Default value is false
```


