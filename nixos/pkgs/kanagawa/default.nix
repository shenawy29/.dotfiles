{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gtk-engine-murrine,
  sassc,
  jdupes,
  gnome-themes-extra,
  themeVariants ? [ ], # default: blue
  colorVariants ? [ ], # default: all
  sizeVariants ? [ ], # default: standard
  tweaks ? [ ],
}:

let
  pname = "kanagawa-gkt-theme";
in

lib.checkListOfEnum "${pname}: theme variants"
  [
    "default"
    "purple"
    "pink"
    "red"
    "orange"
    "yellow"
    "green"
    "blue"
    "grey"
    "all"
  ]
  themeVariants
  lib.checkListOfEnum
  "${pname}: color variants"
  [ "light" "dark" ]
  colorVariants
  lib.checkListOfEnum
  "${pname}: size variants"
  [ "standard" "compact" ]
  sizeVariants
  lib.checkListOfEnum
  "${pname}: tweaks"
  [
    "dragon"
    "black"
    "float"
    "outline"
    "macos"
  ]
  tweaks

  stdenvNoCC.mkDerivation
  {
    inherit pname;
    version = "0-unstable-2025-07-28";

    src = fetchFromGitHub {
      owner = "Fausto-Korpsvart";
      repo = "Kanagawa-GKT-Theme";
      rev = "7c111e58e958c75d66a8d851c7887ce9878cc7bb";
      hash = "sha256-z8MncIVX9YygYmaA6bGpaUzra9uT/am985C6hBocHOI=";
    };

    postPatch = ''
      find -name "*.sh" -print0 | while IFS= read -r -d ''' file; do
        patchShebangs "$file"
      done
    '';

    dontBuild = true;

    nativeBuildInputs = [
      jdupes
      sassc
    ];

    buildInputs = [
      gnome-themes-extra
    ];

    propagatedUserEnvPkgs = [
      gtk-engine-murrine
    ];

    installPhase = ''
      runHook preInstall

      name= HOME="$TMPDIR" ./themes/install.sh \
        ${lib.optionalString (themeVariants != [ ]) "--theme " + builtins.toString themeVariants} \
        ${lib.optionalString (colorVariants != [ ]) "--color " + builtins.toString colorVariants} \
        ${lib.optionalString (sizeVariants != [ ]) "--size " + builtins.toString sizeVariants} \
        ${lib.optionalString (tweaks != [ ]) "--tweaks " + builtins.toString tweaks} \
        --dest $out/share/themes

      jdupes --quiet --link-soft --recurse $out/share

      runHook postInstall
    '';

    meta = with lib; {
      description = "GTK theme with the Kanagawa colour palette";
      homepage = "https://github.com/Fausto-Korpsvart/Kanagawa-GKT-Theme";
      license = licenses.gpl3Only;

      maintainers = with maintainers; [
        iynaix
        shenawy29
      ];

      platforms = lib.platforms.unix;
    };
  }
