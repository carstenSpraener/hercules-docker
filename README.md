# Hercules under Docker

This project is mainly a Dockerfile that pulls, builds and runs the hercules 
IBM Host emulator. The Dockerfile installs by default the TK5 MVS on which 
the emulator is started. 

## Quickstart

```bash
# build the docker image
docker build --tag=hercules-hyperion .
# start hercules as a docker container
./hcStart
# connect with a 3270 terminal to the HOST
c3270 localhost:3270
```

![img.png](doc/image/start.png)

### Running on a pre installed MVS/OS390/ZOS environment
If you have a pre installed MVS, OS390, ZOS or any other hercules 
environment you can mount it to the containers directory /opt/hercules.

By default the folder contains the MVS-TK5 environment. But if it is mount 
to your own environment. To do so call the ```hcStart``` command with tro 
parameters:

```bash
./hcStart /path/to/hercules-environment:/opt/hercules MyName
```

This will start hercules on the pre installed environment and names the 
container hercules-MyName

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


