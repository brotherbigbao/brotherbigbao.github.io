# coding:utf-8
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import serialization, hashes
from cryptography.hazmat.primitives.asymmetric import padding


def read_key(path):
    with open(path, 'rb') as f:
        res = f.read()
        return res


def get_public_key(path):
    key = read_key(path)
    res = serialization.load_pem_public_key(key, backend=default_backend())
    return res


def get_private_key(path):
    key = read_key(path)
    res = serialization.load_pem_private_key(
        key, password=None, backend=default_backend(),
    )

    return res


def decrypt(message, key_file):
    private_key = get_private_key(key_file)
    raw_group = [message[i:i + 256] for i in range(0, len(message), 256)]

    res_group = [_decrypt(i, private_key) for i in raw_group]
    return b''.join(res_group)


def _decrypt(message, private_key):
    text = private_key.decrypt(
        message,
        padding=padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )
    return text


def encrypt(message, key_file):
    public_key = get_public_key(key_file)
    # https://crypto.stackexchange.com/questions/42097/what-is-the-maximum-size-of-the-plaintext-message-for-rsa-oaep
    group_len = 190
    raw_group = [message[i:i+group_len] for i in range(0, len(message), group_len)]
    res_group = [_encrypt(i, public_key) for i in raw_group]
    return b''.join(res_group)


def _encrypt(message, public_key):
    res = public_key.encrypt(
        message,
        padding=padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )
    return res
