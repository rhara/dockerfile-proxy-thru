#!/usr/bin/env python

import sys
import os

txt = open('Dockerfile.proxy_template', 'rt').read()

D = {'image': None, 'userid': None, 'password': None, 'server': None, 'port': None}
X = {1: 'image', 2: 'userid', 3: 'password', 4: 'server', 5: 'port'}

while True:
    print('[1] baseimage: {}'.format(D['image']))
    print('[2] userid: {}'.format(D['userid']))
    print('[3] password: {}'.format(D['password']))
    print('[4] proxyserver: {}'.format(D['server']))
    print('[5] port: {}'.format(D['port']))
    n = input('Number(1-5) or "done" or "abort": ')
    if n in '12345':
        d = int(n)
        k = X[d]
        v = input('{} => '.format(k))
        D[k] = v
    elif n == 'done':
        ok = True
        for k in D:
            if type(D[k]) != str:
                ok = False
                break
        if ok:
            break
        else:
            print('** Input was not complete, please continue **')
    elif n == 'abort':
        sys.exit(-1)
    else:
        print('** Wrong input **')

txt = txt.replace('{{image}}', D['image']).\
        replace('{{userid}}', D['userid']).\
        replace('{{password}}', D['password']).\
        replace('{{server}}', D['server']).\
        replace('{{port}}', D['port'])

if os.path.exists('Dockerfile'):
    os.rename('Dockerfile', 'Dockerfile.saved')
out = open('Dockerfile', 'wt')
out.write(txt)
print('written to Dockerfile')
out.close()
