# FSTextView
继承于UITextView的自定义TextView, 带placeholder和可限制最大输入字符数, 已适配横竖屏切换, 最低支持iOS6.<p>
基本使用方法:<p>
```objc 
FSTextView *textView = [FSTextView textView];
textView.placeholder = @"这是一个继承于UITextView的带Placeholder的自定义TextView, 可以设定限制字符长度, 以Block形式回调, 简单直观 !";
[SuperView addSubview:textView];
// 限制输入最大字符数.
textView.maxLength = 10;
// 添加输入改变Block回调.
[textView addTextDidChangeHandler:^(FSTextView *textView) {
    // 文本改变
}];
// 添加到达最大限制Block回调.
[textView addTextLengthDidMaxHandler:^(FSTextView *textView) {
    // 达到最大限制数
}];
```
<p>
竖屏状态<p>
![Alt text][image-1]<p>
横屏状态<p>
![Alt text][image-2]<p>


[image-1]:https://github.com/lifution/TestImages/blob/master/FSTextView/FSTextView1.png
[image-2]:https://github.com/lifution/TestImages/blob/master/FSTextView/FSTextView2.png
