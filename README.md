HMRepeatableTapGestureRecognizer
====

HMRepeatableTapGestureRecognizer is a gesture that fires a series of tap events while the user presses the view.

# Require

- iOS13+
- Swift5

# usage

```Swift
func setupGesture() {
  let gesture = HMRepeatableTapGestureRecognizer(minimumPressDuration: minimumDuration, repeatInterval: repeatInterval, numberOfTouchRequired: 1, action: { gesture in
      self.count()
    })
  self.plusButton.addGestureRecognizer(gesture!)
}
```

[Example: ViewController.swift](https://github.com/hmuronaka/HMRepeatableTapGestureRecognizer/blob/main/HMRepeatableTapGestureRecognizerExample/HMRepeatableTapGestureRecognizerExample/ViewController.swift#L39)

# LICENSE

MIT
