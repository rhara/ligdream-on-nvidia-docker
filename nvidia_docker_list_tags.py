from urllib import request as req
import json

url = 'https://registry.hub.docker.com/v2/repositories/nvidia/cuda/'

desc = json.loads(req.urlopen(req.Request(url)).read())['full_description']

show = False
for line in desc.split('\n'):
    line = line.rstrip()
    if show:
        print(line)
    else:
        if line == '## Tags':
            show = True
            print(line)
            continue



