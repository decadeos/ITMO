#!/bin/bash

period_s=$1
period_ms=$(($period_s*1000))
icon=/home/eva/images/11962_2005.jpg

notify-send -i $icon -t $period_ms "Time to relax, senpai!" "${period_s} seconds"

