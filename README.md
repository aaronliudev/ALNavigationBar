#headerView+NavigationBar渐变

##headerView
```obcj
[self configHeaderView:self.contentView];
[self configHeaderImage:[UIImage imageNamed:@"bridge"]];
```
其原理很简单，滑动tableView时contentOffset发生变化从而改变imageView的frame。当contentOffset发生变化时，赋值给headerView的属性，使用KVO来改变frame

##NavigationBar渐变
```objc
// 将背景置空
[self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
// 去掉navigationBar的阴影细线
[self setShadowImage:[UIImage new]];
```
然后在创建一个视图barView添加到navigationBar上，改变barView的颜色，透明度

直接在viewDidload中添加以下代码就可以搞定
```
self.navigationController.navigationBar.al_navigationBarStyle = ALNavigationBarDefault;
```

另外demo中还添加了UIBarButtonItem的自定义以及UIBarButtonItem的badge
