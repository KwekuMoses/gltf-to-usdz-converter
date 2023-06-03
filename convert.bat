@echo off
setlocal

set DOCKER_IMAGE=leon/usd-from-gltf:latest
set DOCKER_CMD=docker run -i --rm -v "%cd%:/usr/app" %DOCKER_IMAGE%
set INPUT_FILE=%~1
set OUTPUT_FILE=%~n1.usdz

%DOCKER_CMD% %INPUT_FILE% %OUTPUT_FILE%
