source $stdenv/setup

echo "unpacking $src..."
ensureDir $out/share
cd $out/share
tar xvfa $src   # -> firefox

for lib in `find -name '*.so'` ; do
    patchelf --set-rpath $libPath:$out/firefox $lib
done

for bin in `find -perm +0100 -type f | grep -v '\.s[oh]$'` ; do
    echo $bin
    patchelf --interpreter "$(cat $NIX_GCC/nix-support/dynamic-linker)" \
             --set-rpath $libPath:$out/firefox $bin
done

ensureDir $out/bin
cd $out/bin
cat >firefox <<EOF
#!/bin/sh

export ALSA_PLUGIN_DIRS=$alsa_path/lib/alsa-lib
export LD_PRELOAD=$google_talk_plugin_path/libexec/google/talkplugin/libpreload.so

export MOZ_PLUGIN_PATH=\$MOZ_PLUGIN_PATH\${MOZ_PLUGIN_PATH:+:}$flashplayer_path/lib/mozilla/plugins
export MOZ_PLUGIN_PATH=\$MOZ_PLUGIN_PATH\${MOZ_PLUGIN_PATH:+:}$jre_path/jre/lib/i386/plugins
export MOZ_PLUGIN_PATH=\$MOZ_PLUGIN_PATH\${MOZ_PLUGIN_PATH:+:}$google_talk_plugin_path/lib/mozilla/plugins

exec $out/share/firefox/firefox
EOF

chmod a+x firefox
