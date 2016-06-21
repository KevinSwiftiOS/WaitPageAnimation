# -
模仿他人的代码做了一个等待进入的动画。
主要是把layer这一层给抽象出来，随后在animationView中添加不同的图形，来做出最后的效果
required init?(coder aDecoder: NSCoder) {
fatalError("init(coder:) has not been implemented")

}
是类指定的构造器 是从storyboard来进行初始化,init的几个构造器 可以从这个博客了解到
http://draveness.me/swift-zhong-init-de-shi-yong/
还有是一些动画的使用等。各个坐标是都计算好才得出的，感觉非常的棒，CALayer的重绘，也有了更深一步的提现