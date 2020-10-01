#!/bin/bash

grep -H ^TOP= /reg/d/iocData/*/iocInfo/IOC.epicsEnvShow |grep ads-ioc
