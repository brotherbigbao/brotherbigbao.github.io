# openssl

#### php5.5必须将密钥按照64位截取

```php
$res = "-----BEGIN PUBLIC KEY-----\n" .
    wordwrap($pubKey, 64, "\n", true) .
    "\n-----END PUBLIC KEY-----";
```