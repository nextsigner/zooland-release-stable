import datetime
import sys

#print('Args: ', sys.argv)

dia = sys.argv[1]
mes = sys.argv[2]
anio = sys.argv[3]
hora = sys.argv[4]
min = sys.argv[5]
gmt = sys.argv[6]

#print('Fecha: '+dia+'/'+mes+'/'+anio+' Hora: '+hora+':'+min)

d = datetime.datetime(int(anio),int(mes),int(dia),int(hora), int(min))
horaLocal = d + datetime.timedelta(hours=int(gmt))
print(horaLocal)
