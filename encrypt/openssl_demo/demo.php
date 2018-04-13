<?php

function encrypt($data, $key)
{
    $key = file_get_contents($key);
    $public_key = openssl_pkey_get_public($key);
    $bits = openssl_pkey_get_details($public_key)['bits'];
    $size = ($bits / 8) - 11;
    $bytes = '';
    foreach (str_split($data, $size) as $chunk) {
        openssl_public_encrypt($chunk, $s, $public_key);
        $bytes .= $s;
    }
    return $bytes;
}

function decrypt($bytes, $key)
{
    $key = file_get_contents($key);
    $private_key = openssl_pkey_get_private($key);
    $bits = openssl_pkey_get_details($private_key)['bits'];
    $size = $bits / 8;
    $data = '';
    foreach (str_split($bytes, $size) as $chunk) {
        openssl_private_decrypt($chunk, $s, $private_key);
        $data .= $s;
    }
    return $data;
}

$data = array(
);
$post_data = encrypt(json_encode($data), '../key/rsa_public_key.pem');

$curl = curl_init();
curl_setopt($curl, CURLOPT_URL, '');
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($curl, CURLOPT_POST, 1);
curl_setopt($curl, CURLOPT_POSTFIELDS, $post_data);
$data = curl_exec($curl);
curl_close($curl);

$resp_data = decrypt($data, '../key/rsa_private_key.pem');
$resp = json_decode($resp_data, true);
var_dump($resp);
