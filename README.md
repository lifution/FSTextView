# FSTextView
继承于UITextView的自定义TextView, 带placeholder和可限制最大输入字符数, 已适配横竖屏切换, 最低支持iOS6.<p>

###### 2017/07/29 更新 `version 1.4`: <p>

Fix: 达到最大限制字符数后 Undo 行为导致crash.

###### 2017/07/19 更新 `version 1.3`: <p>

Fix: 在 `Storyboard` 中设置 `text` 后, 字符限制没有生效和 placeholder 没有自动隐藏的问题.

新增: 添加 `canPerformAction` 属性来设定 `FSTextView` 是否允许长按弹出UIMenuController.

###### 2017/04/14 更新 `version 1.2`: <p>

修复 [#issue5](https://github.com/lifution/FSTextView/issues/5)<p>
删除了原来重载的父类属性 `text` 的 `getter` 方法, 如果需要获取一个去除首尾空格和换行符的字符串则调用 `formatText` 即可. <p>

```objc
FSTextView *textView = [FSTextView textView];
textView.formatText; // 该属性获取到的字符串为去除首尾空格和换行符的.
```

###### 2017/04/02 更新 `version 1.1`: <p>
更换注册通知的方式, 避免影响其它的 `FSTextView` 实例.

##### 支持使用CocoaPods引入, Podfile文件中添加:

```objc
pod 'FSTextView'
```

注: 使用CocoaPods引入的话, 纯代码创建没有任何问题, 但在Storyboard中设置时会提示 `Fail to update auto layout status: Fail to load designables from path (null)`解决办法是在Podfile文件中添加`use_frameworks!`在`target 'YourProjectName' do`前即可, 但这个方法只能是iOS8及往后版本才行, 如果你的项目版本支持的是iOS7及之前版本的话会报错, 或者你可以找到`Pod`文件夹中`FSTextView`的源码, 删除`FSTextView.h`中的`IB_DESIGNABLE`字段（删除后就没有了Storyboard中`FSTextView`的相关属性即设置即显示的效果）.<p>
基本使用方法:<p>

```objc
FSTextView *textView = [FSTextView textView];
textView.placeholder = @"这是一个继承于UITextView的带Placeholder的自定义TextView, 可以设定限制字符长度, 以Block形式回调, 简单直观 !";
// 限制输入最大字符数.
textView.maxLength = 10;
// 添加输入改变Block回调.
[textView addTextDidChangeHandler:^(FSTextView *textView) {
    // 文本改变后的相应操作.
}];
// 添加到达最大限制Block回调.
[textView addTextLengthDidMaxHandler:^(FSTextView *textView) {
    // 达到最大限制数后的相应操作.
}];
```

竖屏状态<p>
![Alt text][image-1]

横屏状态<p>
![Alt text][image-2]

##### 目前已知的小问题: (不影响使用, Xcode8.3 已修复了这个问题)
在Storyboard中设置Placeholder颜色不会在Storyboard上马上呈现, 但是其实已经修改成功的了, 运行时Placeholder的颜色会是你所设置的颜色.<p>

# LICENSE
FSTextView is available under the MIT license. See the LICENSE file for more info.

[image-1]:http://oeysrv69b.bkt.clouddn.com/FSTextView1.jpg
[image-2]:http://oeysrv69b.bkt.clouddn.com/FSTextView2.jpg


