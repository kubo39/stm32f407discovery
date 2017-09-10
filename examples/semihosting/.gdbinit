set print pretty on
target remote :3333
monitor arm semihosting enable
monitor itm port 0 on
monitor tpiu config external uart off 8000000 2000000
load
continue
