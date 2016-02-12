# 小数計算機能付き電卓

※すべての実装に納得してるわけではないです。よりよいのあれば教えて下さい

ViewControllerは箱、電卓の機能はCalcControllerが持つ
（デザインの違う電卓を誰かが作っても、Controllerをひっぱってきて、中の機能を呼び出すだけで良い）
逆に、Viewの更新とかは、calcControllerには書かない

「電卓」という箱は、２つの数字と演算子があれば十分。（Calc）

```swift
let number = button.tag - 10
controller.appendNumber(number)
```

tag-10みたいな、意味の分からないメタ的な処理は、numberみたいな定数に置き換えて、意味をわかりやすくする
（今回なら、numberがおされた数字の番号なんだな、という感じ）

関数名は動詞が先

変数名は小文字始まりのcamelCase、静的定数(static let)はUPPER_SNAKE_CASE

calcControllerのインスタンスはstaticなmanagerから受け取る

ModelManagerは、calcControllerが使われるまでメモリを確保しない、当然_calcControllerが外部から書き換えられる必要はないのでprivate

```swift
if ceil(self) == floor(self) {
    return true
} else {
    return false
}
```

結果が対等なら、elseを書かなくても動作は同じでも、対等であるように見せる


```swift
if inputPlace == 1.0 {
    // 整数入力モード
```

メタ的な処理だが、そう書かざるをえない場合は、コメントを添える


Copyright @ha1f All rights reserved.
