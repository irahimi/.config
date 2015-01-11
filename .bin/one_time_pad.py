#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import os
import itertools
import argparse
from string import digits, letters, punctuation

usable = digits + letters + punctuation + ' '
encoding = dict((usable[i], i) for i in range(len(usable)))
MOD      = len(encoding)

def ordc(char):
    return encoding[char]

def chrc(num):
    return dict(zip(encoding.values(), encoding.keys()))[num]

__all__ = ('encrypt', 'decrypt')

def error(message):
    print("[!] ERROR: {}".format(message))

def encrypt(plaintext, key = None):
    if key == None:
        key = []
        while len(key) < len(plaintext):
            char = os.urandom(1)
            if char in usable:
                key.append(char)
        key = ''.join(key)

    output = []
    for plain_char, key_char in itertools.izip(plaintext, itertools.cycle(key)):
        output.append(chrc((ordc(plain_char) + ordc(key_char)) % MOD))

    return (''.join(output).__repr__(), key)

def decrypt(ciphertext, key):
    output = []
    for cipher_char, key_char in itertools.izip(ciphertext, itertools.cycle(key)):
        output.append(chrc((ordc(cipher_char) - ordc(key_char)) % MOD))

    return ''.join(output)

if __name__ == '__main__':
    parser = argparse.ArgumentParser("One Time Pad Cipher")
    parser.add_argument('-d', dest='decrypt', action='store_true', required=False)
    parser.add_argument('-k', dest='key', action='store', required=False)
    parser.add_argument('message', action='store')
    argv = parser.parse_args()

    if not argv.key:
        if argv.decrypt:
            error("Cannot decrypt without a key.")
        else:
            data = encrypt(argv.message)
            print("[+] Key:      '{0}'".format(data[1]))
            print("[+] Message:  '{0}'".format(data[0]))
    else:
        if argv.decrypt:
            print("[+] Message:  '{0}'".format(decrypt(argv.message, argv.key)))
        else:
            print("[+] Message:  {0}".format(encrypt(argv.message, argv.key)[0]))
