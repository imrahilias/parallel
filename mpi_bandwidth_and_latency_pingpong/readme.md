# pingpong

Comparing `mpi_send()` with `mpi_ssend()` in a simple pingpong program
for package sizes from 8 bytes to 2 megabytes.


## Use

Type `make` to compile and run the program `pingpong`.


## Bandwith
the bandwidth increases first with the package size, before declining
again for larger packets. sync/async impact nicely decreases with
package size.


## Latency
the latency, thus transfer time using smallest package size, is
heavily affected by sync/async send.


## Syncronous `mpi_ssend()`

| buffer size /bytes | transfer time / us | bandwidth / mb/s |
|--------------------|--------------------|------------------|
| 8                  | 1.439              | 5.55             |
| 512                | 2.0147             | 254.130          |
| 32768              | 12.830             | 2553.974         |
| 2097152            | 1633.034           | 1284.205         |


## Asyncronous `mpi_send()`

| buffer size /bytes | transfer time / us | bandwidth / mb/s |
|--------------------|--------------------|------------------|
| 8                  | 2.850              | 2.806            |
| 512                | 2.713              | 188.712          |
| 32768              | 15.663             | 2092.046         |
| 2097152            | 1505.099           | 1393.364         |

