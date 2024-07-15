#!/bin/bash

printf "%-10s %-5s %-5s %-10s %s\n" "PID" "TTY" "STAT" "TIME" "COMMAND"

for pid in /proc/[0-9]*/; do
    # Получаем идентификатор процесса из каталога
    pid="${pid%/}"
    pid="${pid##*/}"

    # Проверяем, принадлежит ли процесс текущему пользователю
    if [ "$(stat -c %U /proc/$pid)" = "$(whoami)" ]; then
        # Считайте TTY из state фйла
        tty=$(awk '{print $7}' /proc/$pid/stat)
        if [ "$tty" = "0" ]; then
            tty="?"
        fi

        # Считайте статус процесса из ыфайла состояния
        status=$(awk '/State/ {print $2}' /proc/$pid/status)

        # Read the process's command line from the cmdline file
        cmd=$(tr '\0' ' ' < /proc/$pid/cmdline)

        # Read the process's total CPU time from the stat file
        utime=$(awk '{print $14}' /proc/$pid/stat)
        stime=$(awk '{print $15}' /proc/$pid/stat)
        total_time=$((utime + stime))
        total_time=$((total_time / 100))

        # Print the process information in the same format as ps ax
        printf "%-10s %-5s %-5s %02d:%02d:%02d %s\n" "$pid" "$tty" "$status" "$(($total_time / 3600))" "$((($total_time % 3600) / 60))" "$(($total_time % 60))" "$cmd"
    fi
done
