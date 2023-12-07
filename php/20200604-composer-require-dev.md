# composer require-dev
>require-dev包中指定的依赖只有在根项目中才会安装

## require-dev (root-only)

这个列表是为开发或测试等目的，额外列出的依赖。“root 包”的 require-dev 默认是会被安装的。然而 install 或 update 支持使用 --no-dev 参数来跳过 require-dev 字段中列出的包。

## Root包

“root 包”是指由 composer.json 定义的在你项目根目录的包。这是 composer.json 定义你项目所需的主要条件。（简单的说，你自己的项目就是一个 root 包）

某些字段仅适用于“root 包”上下文。 config 字段就是其中一个例子。只有“root 包”可以定义。在依赖包中定义的 config 字段将被忽略，这使得 config 字段只有“root 包”可用（root-only）。

如果你克隆了其中的一个依赖包，直接在其上开始工作，那么它就变成了“root 包”。与作为他人的依赖包时使用相同的 composer.json 文件，但上下文发生了变化。

注意： 一个资源包是不是“root 包”，取决于它的上下文。 例：如果你的项目依赖 monolog 库，那么你的项目就是“root 包”。 但是，如果你从 GitHub 上克隆了 monolog 为它修复 bug， 那么此时 monolog 就是“root 包”。

![Visitor Count](https://profile-counter.glitch.me/brotherbigbao/count.svg)