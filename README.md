# RTLSDR-Airband docker container image #

A [szpajder/RTLSDR-Airband](https://github.com/szpajder/RTLSDR-Airband) docker
container image, built on top of alpine linux, for the arm32v6 architecture.

It is compiled for the `rpiv2` platform (see the
[Compilation](https://github.com/szpajder/RTLSDR-Airband/wiki/Compilation) page
on the upstream repo).

## How to run ##

```
docker run \
  --privileged \
  -v $PWD/rtl_airband.conf:/rtl_airband.conf \
  danmilon/rtlsdr-airband-rpiv2-arm32v6
```

Running it as privileged is an easy way to provide access to the USB device,
but of course it's unsecure, and I don't have an alternative at the moment. One
can pass through the USB device file (`/dev/bus/usb/xxx/yyy`) to the container,
but the bus ID the device ends at is non deterministic. It's possible to use
udev rules based on the device serial number, and symlink it to a predictable
path, but then librtlsdr doesn't see it.
