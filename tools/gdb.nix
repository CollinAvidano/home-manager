{pkgs, inputs, ...}: let
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

  # TODO boost version as an option? Like that being version dependent is the one reason I dont like the above being together
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
    sys.path.append('${merged-pretty-printers}')
    from libstdcxx.v6.printers import register_libstdcxx_printers
    register_libstdcxx_printers (None)
    from eigen.printers import register_eigen_printers
    register_eigen_printers (None)
    import boost
    boost.register_printers(boost_version=(1,4,8))
    end
  '';
}