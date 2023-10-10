# PHP rawurlencode 與 urlencode 的差異
> URL Encode 有分 rawurlencode() 與 urlencode() 這兩種，兩者有什麼差異呢？


## PHP 的 urlencode() 官方說明

- 返回字元串，此字元串中除了 -_. 之外的所有非字母數字字元都將被替換成百分號（%）後跟兩位十六進制數，空格則編碼為加號（+）。
- 此編碼與 WWW 表單 POST 數據的編碼方式是一樣的，同時與 application/x-www-form-urlencoded 的媒體類型編碼方式一樣。
- 由於歷史原因，此編碼在將空格編碼為加號（+）方面與 » RFC3986 編碼（參見 rawurlencode()）不同。

## PHP 的 rawurlencode() 官方說明

- 返回字元串，此字元串中除了 -_. 之外的所有非字母數字字元都將被替換成百分號（%）後跟兩位十六進制數。
- 這是在 » RFC 3986 中描述的編碼，是為了保護原義字元以免其被解釋為特殊的 URL 定界符，同時保護 URL 格式以免其被傳輸媒體（像一些郵件系統）使用字元轉換時弄亂。

## 上述說明還是很難懂，這邊做個比較簡單的說明：

- UrlEncode 的定義，RFC 3986 有定義一個標準，但是 HTTP 也定義另外一個標準，但是兩個標準基本上是一致的，但是在某些保留字上有些出入。
- 其中最明顯的案例就是「空白字元」

## RFC 3986 與 HTTP 定義的空白字元差異

- RFC 3986 - Uniform Resource Identifier (URI): Generic Syntax
  -  規範 「空白字元」→ %20
  - ex: DVD player 會轉換成 DVD%20player
- HTTP 對 GET / POST 傳遞參數 (application/x-www-form-urlencoded) - RFC 1866 - Hypertext Markup Language - 2.0
  - 規範 「空白字元」→ +
  - ex: DVD player 會轉換成 DVD+player

## 結論
除了 PHP 的以外，也把其它程式語言一起列出來。

### PHP

- urlencode 是走 HTTP (RFC 1866)：空白字元用「+」
- rawurlencode 是走 RFC 3986：空白字元用「%20」

### JavaScript

- encodeURI、encodeURIComponent：空白字元用「%20」，要做 application/x-www-form-urlencoded (AJAX POST)的話，要自己把 「%20」 換成 「+」

### Python 2

- urllib.urlencode：空白字元用「+」

### Python 3

- urllib.parse.urlencode：空白字元用「%20」

> [php - urlencode vs rawurlencode?](http://stackoverflow.com/questions/996139/urlencode-vs-rawurlencode)

> [URL Encoding](http://www.blooberry.com/indexdot/html/topics/urlencoding.htm)

> [本文原文在此](https://blog.longwin.com.tw/2015/11/php-rawurlencode-urlencode-diff-2015/)

![Visitor Count](https://profile-counter.glitch.me/liuyibao/count.svg)