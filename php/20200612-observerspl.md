# 利用 SPL 快速实现 Observer 设计模式
> 胡 屹 2012 年 1 月 16 日发布

## 什么是 SPL

SPL（Standard PHP Library）即标准 PHP 库，是 PHP 5 在面向对象上能力提升的真实写照，它由一系列内置的类、接口和函数构成。SPL 通过加入集合，迭代器，新的异常类型，文件和数据处理类等提升了 PHP 语言的生产力。它还提供了一些十分有用的特性，如本文要介绍的内置 Observer 设计模式。

本文介绍如何通过使用 SPL 提供的 SplSubject和 SplObserver接口以及 SplObjectStorage类，快速实现 Observer 设计模式。

SPL 在大多数 PHP 5 系统上都是默认开启的，尽管如此，由于 SPL 的功能在 PHP 5.2 版本发生了引人注目的改进，所以建议读者在实践本文内容时，使用不低于 PHP 5.2 的版本。

## SplSubject 和 SplObserver 接口

Observer 设计模式定义了对象间的一种一对多的依赖关系，当被观察的对象发生改变时，所有依赖于它的对象都会得到通知并被自动更新，而且被观察的对象和观察者之间是松耦合的。在该模式中，有目标（Subject）和观察者（Observer）两种角色。目标角色是被观察的对象，持有并控制着某种状态，可以被任意多个观察者作为观察的目标，SPL 中使用 SplSubject接口规范了该角色的行为：

[阅读全文请点击](https://www.ibm.com/developerworks/cn/opensource/os-cn-observerspl/)
[Github DesignPatternsPHP](https://github.com/domnikl/DesignPatternsPHP)

![Visitor Count](https://profile-counter.glitch.me/liuyibao/count.svg)