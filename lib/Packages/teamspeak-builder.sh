source $stdenv/setup

mkdir -p $out/bin
cd $out/bin
cat >teamspeak <<EOF
#!/bin/sh

export LIBGL_DRIVERS_PATH=$mesa_path/lib/dri

exec $ts_path/bin/ts3client
EOF
chmod a+x teamspeak
