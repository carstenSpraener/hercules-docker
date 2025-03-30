# Hercules under Docker

This project is mainly a Dockerfile that pulls, builds and runs the hercules 
IBM Host emulator.

## Building and running

```bash
docker build --tag=hercules-hyperion .
./hcStart /src/hercules-env/TK4 tk4
c3270 localhost 3270
```
## Ports
The following ports should be published:

* 3270 to connect a 3270 terminal
* 3278 to ??
* 8038 for a (eventually) configured web frontend

## Volumes
The container can take a hercules environment under the path 
```/opt/hercules```. The mounted directory should contain all files 
necessary for hercules to run a HOST environment.

## Requirements

The start script assumes that the initial program load script is in the 
```scripts/ipl.rc``` file of you mounted environment.

The configuration has to be stored in the conf/hercules.cnf file.


