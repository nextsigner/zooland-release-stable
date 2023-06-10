# -*- coding: utf-8 -*-
import sys, os, pathlib, json
import subprocess
from subprocess import run, PIPE

file = open('/media/ns/ZONA-A1/zool/360.html',mode='r')
signData = file.read().split('---\n')
file.close()

#print(len(signData))
j={}
indexSign=0




#for s in signData:
    #f = open("/home/ns/s"+str(indexSign)+".html", "a")
    #f.write(s)
    #f.close()
    #indexSign = indexSign + 1


indexSign=0
for s in range(12):
    for ng in range(30):
        sg=''
        if ng < 9:
            sg='>0'+str(ng + 1)+'° '
        else:
            sg='>'+str(ng + 1)+'° '
        #print(sg)
        cmd1=['/media/ns/ZONA-A1/zool/resources/cat360grep.sh', "/home/ns/s"+str(indexSign)+".html", sg]
        #print(str(cmd1))
        proc = subprocess.Popen(args=cmd1, stdout=subprocess.PIPE)
        output = proc.stdout.read()
        data = str(output.decode("utf-8"))
        #data = str(output)
        #print(data)
        #data = str(output.encode("utf-8"))
        mp=data.split('<p ')
        indexP=0
        for p in mp:
            if 's'+str(indexSign) not in j:
                j['s'+str(indexSign)] = {}
            item=j['s'+str(indexSign)]
            if 'g'+str(ng) not in item:
                item['g'+str(ng)]={}
            #itemP=
            if 'p'+str(indexP) not in item['g'+str(ng)] and indexP > 0:
                parrafo= str(p)

                mstrong=parrafo.split(':°')
                pstrong1=str(mstrong[0])
                tipo=-2
                if pstrong1.find('rgb(255, 0, 0)')>0:
                    tipo=0
                elif pstrong1.find('rgb(0, 0, 255)')>0:
                    tipo=1
                else:
                    tipo=-1

                item['g'+str(ng)]['p'+str(indexP)]={'text': '<p '+parrafo, 'tipo': tipo}

            indexP = indexP + 1

        #print(data)
    indexSign = indexSign + 1


#print(json.dumps(j['s0'], sort_keys=False, indent=4, ensure_ascii=False))

f = open("/home/ns/sabianos.json", "w")
f.write(json.dumps(j, sort_keys=False, indent=4, ensure_ascii=False))
f.close()
#print(json.dumps(j))
