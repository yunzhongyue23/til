<a name="yJqVL"></a>
## 一般模式
| yy | 源自copy | 复制当前光标一行 |
| --- | --- | --- |
| num+yy | <br /> | 复制num行 |
| p | paste | 粘贴 |
| yw | copy+word | 复制一个单词 |
| u | undo | 撤销 |
| dd | delete | 删除一行 |
| num+dd |  | 删掉num行 |
| dw | delete + word  | 删掉一个单词 |
| x | 样子像剪刀 | 剪切一个字母,相当于del |
| X | 样子像剪刀 | 剪切一个字母,相当于backspace |
| shift+6(^) | 正则中的开头(火箭头) | 光标跳转到开头 |
| shift+4($) | 月末发工资了 | 光标跳转到行尾 |
| gg | 全文(global)跳转 | 光标跳转到文档开始行首 |
| shift +g | 全文(global)跳转 | 光标跳转到文档结束行首 |

<a name="BfDvj"></a>
## 编辑模式
| i | insert | 当前光标停留的地方开始插入 |
| --- | --- | --- |
| a | append | 当前光标之后追加插入 |
| o | open line | 下面打开新的一行插入 |
| I | insert | 在行首插入 |
| A | append | 行尾追加插入 |
| O | open line | 上面打开新的一行插入 |

<a name="Dh0ll"></a>
## 指令模式
| :w | write | 保存 |
| --- | --- | --- |
| :q | quit | 退出 |
| :! | 看看大棒的威力 | 强制操作 |
| /要查找的词 | n查找下一个(next),shift+n查找上一个 |  |
| :noh | no highlight | 不高亮 |
| :set nu | (nu)number, | 显示行号 |
| :set nonu |  | 关闭行号 |
| :%s/old/new/g | s(search),g(global), | 全局搜索替换 |

