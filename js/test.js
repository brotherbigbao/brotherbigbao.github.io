var jq = document.createElement('script');
jq.src = 'https://cdn.bootcss.com/jquery/3.4.1/jquery.js';
document.getElementsByTagName('head')[0].appendChild(jq);

function liuyibaoClick()
{
    jQuery("#Button2").click();
}

setTimeout("liuyibaoClick()", 1300000);//15分钟