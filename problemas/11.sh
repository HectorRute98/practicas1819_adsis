#!/bin/bash
#Obtener los usuarios del sistema cuyo UID sea mayor que 99
egrep '^([^:]*:){2}[0-9]{3,}' /etc/passwd | cut -d -f1
#cat /etc/passwd |cut -f1-3 -d: | egrep?[0-9]{3,}$?

