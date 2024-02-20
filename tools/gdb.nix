{pkgs, inputs, ...}: let
  stdlib-pretty-printers = pkgs.stdenvNoCC.mkDerivation {
    name = "stdlib-pretty-printers";
    version = "13.2";
    src = "${inputs.stdlib-pretty-printers}/libstdc++-v3/python";
    dontConfigure = true;
    dontBuild = true;
    dontPatch = true;
    installPhase = ''
      runHook preInstall
      cp -r $src/python/libstdcxx $out/libstdcxx
      runHook postInstall
    '';
  };

  eigen-pretty-printers = pkgs.stdenvNoCC.mkDerivation {
    name = "eigen-pretty-printers";
    src = "${inputs.eigen-pretty-printers}/debug";
    dontConfigure = true;
    dontBuild = true;
    dontPatch = true;
    installPhase = ''
      cp -r $src/debug/gdb $out/eigen
    '';
  };

  boost-pretty-printers = pkgs.stdenvNoCC.mkDerivation {
    name = "boost-pretty-printers";
    src = "${inputs.boost-pretty-printers}/libstdc++-v3/python";
    dontConfigure = true;
    dontBuild = true;
    dontPatch = true;
    installPhase = ''
      runHook preInstall
      cp -r $src/boost $out/boost
      runHook postInstall
    '';
  };

  merged-pretty-printers = pkgs.stdenvNoCC.mkDerivation {
    name = "merged-pretty-printers";
    srcs = [
      "${inputs.stdlib-pretty-printers}/libstdc++-v3/python"
      "${inputs.eigen-pretty-printers}/debug"
      "${inputs.boost-pretty-printers}"
    ];
    sourceRoot = ".";
    dontConfigure = true;
    dontBuild = true;
    dontPatch = true;
    installPhase = ''
      runHook preInstall
      cp -r $src/python/libstdcxx $out/libstdcxx
      cp -r $src/debug/gdb $out/eigen
      cp -r $src/boost $out/boost
      runHook postInstall
    '';
  };
in {
  home.file.".gdbinit".text = ''
    set history save on
    set history size unlimited

    set debuginfod enabled on
    set output-radix 16
    set mi-async 1
    set pagination off
    set non-stop on
    python
    import sys
    # sys.path.append('${merged-pretty-printers}')
    sys.path.append('${stdlib-pretty-printers}')
    sys.path.append('${eigen-pretty-printers}')
    sys.path.append('${boost-pretty-printers}')
    from libstdcxx.v6.printers import register_libstdcxx_printers
    register_libstdcxx_printers (None)
    from eigen.printers import register_eigen_printers
    register_eigen_printers (None)
    import boost
    boost.register_printers(boost_version=(1,4,8))
    end
  '';
}