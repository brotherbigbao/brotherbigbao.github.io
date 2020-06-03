# JetBrains代码搜索技巧
>使用正则匹配快速定位代码

## 擅用(.|\n)*

下面的正则可以直接匹配到代码
```
ShopMember::find\((.|\n)*uid(.|\n)*status(.|\n)*last_active_time(.|\n)*belong_shop_ids
```

可以直接定位到代码位置
```
$member_query = ShopMember::find()->where(['uid' => $uid, 'status'=>1]);

$date = isset($params['date']) ? $params['date'] : date('Y-m-d');
$member_query->andWhere(['BETWEEN', 'last_active_time', $date, "{$date} 23:59:59"]);

if ( ! empty($params['belong_shop_ids'])) {
    if (is_int($params['belong_shop_ids'])) {
        $params['belong_shop_ids'] = [$params['belong_shop_ids']];
    }

    $query_filter_shop_where = ['OR', ['belong_shop_ids' => '']];
    foreach ($params['belong_shop_ids'] as $shop_id) {
        $query_filter_shop_where[] = ['LIKE', 'belong_shop_ids', '%-'.strtr($shop_id, ['%'=>'\%', '_'=>'\_', '\\'=>'\\\\']).'-%', false];
    }

    $member_query->andWhere($query_filter_shop_where);
}

return $member_query->count();
```

> 在正则表达式中dot几乎匹配任意一个字符，但是不匹配换行符\n