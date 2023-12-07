# yii2 mysql 重连
> yii2中mysql并没有重连机制 需要手动修改

## 网上找的一种方案

[转自这里：活着改变世界](https://blog.csdn.net/weixin_34443284/article/details/113467194)

配置项新增

```
'db' => [
    'class' => 'QttLib\Yii\Tracing\DBConnection',
    'commandClass' => 'common\components\DbCommand',// 加上这一条配置,Yii2 解决2006 MySQL server has gone away问题
    'dsn' => 'mysql:host=xxx;dbname=xx',
    'username' => 'xx',
    'password' => 'xxx',
    'charset' => 'utf8',
    'enableLogging' => true,
],
```

新增类

```
namespace common\components;
use Yii;

/**
* 新增加执行sql时断开重连
* 数据库连接断开异常
* errorInfo = [''HY000',2006,'错误信息']
* Class DbCommand
* @package common\components
*/
class DbCommand extends \yii\db\Command
{

    const EVENT_DISCONNECT = 'disconnect';

    /**
    
    * 处理修改类型sql的断线重连问题
    * @return int
    * @throws \Exception
    * @throws \yii\db\Exception
    */
    
    public function execute()
    {
        try{
            return parent::execute();
        }catch(\Exception $e){
            if($this->handleException($e))
            return parent::execute();
            throw $e;
        }
    
    }

    /**
    * 处理查询类sql断线重连问题
    * @param string $method
    * @param null $fetchMode
    * @return mixed
    * @throws \Exception
    * @throws \yii\db\Exception
    */
    protected function queryInternal($method, $fetchMode = null)
    {
        try{
            return parent::queryInternal($method, $fetchMode);
        }catch(\Exception $e){
            if($this->handleException($e))
            return parent::queryInternal($method, $fetchMode);
            throw $e;
        }
    }

    /**
    * 处理执行sql时捕获的异常信息
    * 并且根据异常信息来决定是否需要重新连接数据库
    * @param \Exception $e
    * @return bool true: 需要重新执行sql false: 不需要重新执行sql
    */
    private function handleException(\Exception $e)
    {
        //如果不是yii\db\Exception异常抛出该异常或者不是MySQL server has gone away
        $offset = stripos($e->getMessage(),'MySQL server has gone away');
        if(($e instanceof \yii\db\Exception) == false OR $offset === false)
        return false;
        $this->trigger(static::EVENT_DISCONNECT);
    
        //将pdo设置从null
        $this->pdoStatement = NULL;
        $this->db->close();
        return true;
    }
}
```

## 实际上这个太简陋了，可以参考下laravel的

laravel源码搜索： DetectsLostConnections   或  causedByLostConnection

实际是这样做的：

```
protected function causedByLostConnection(Throwable $e)
{
    $message = $e->getMessage();

    return Str::contains($message, [
        'server has gone away',
        'no connection to the server',
        'Lost connection',
        'is dead or not enabled',
        'Error while sending',
        'decryption failed or bad record mac',
        'server closed the connection unexpectedly',
        'SSL connection has been closed unexpectedly',
        'Error writing data to the connection',
        'Resource deadlock avoided',
        'Transaction() on null',
        'child connection forced to terminate due to client_idle_limit',
        'query_wait_timeout',
        'reset by peer',
        'Physical connection is not usable',
        'TCP Provider: Error code 0x68',
        'ORA-03114',
        'Packets out of order. Expected',
        'Adaptive Server connection failed',
        'Communication link failure',
        'connection is no longer usable',
        'Login timeout expired',
        'SQLSTATE[HY000] [2002] Connection refused',
        'running with the --read-only option so it cannot execute this statement',
        'The connection is broken and recovery is not possible. The connection is marked by the client driver as unrecoverable. No attempt was made to restore the connection.',
        'SQLSTATE[HY000] [2002] php_network_getaddresses: getaddrinfo failed: Try again',
        'SQLSTATE[HY000] [2002] php_network_getaddresses: getaddrinfo failed: Name or service not known',
        'SQLSTATE[HY000]: General error: 7 SSL SYSCALL error: EOF detected',
        'SQLSTATE[HY000] [2002] Connection timed out',
        'SSL: Connection timed out',
        'SQLSTATE[HY000]: General error: 1105 The last transaction was aborted due to Seamless Scaling. Please retry.',
        'Temporary failure in name resolution',
    ]);
}
```

![Visitor Count](https://profile-counter.glitch.me/brotherbigbao/count.svg)