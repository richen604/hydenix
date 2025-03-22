# This module extends home.file, xdg.configFile and xdg.dataFile with the `mutable` option.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  fileOptionAttrPaths = [
    [
      "home"
      "file"
    ]
    [
      "xdg"
      "configFile"
    ]
    [
      "xdg"
      "dataFile"
    ]
  ];
in
{
  options =
    let

      mergeAttrsList = builtins.foldl' (lib.mergeAttrs) { };

      fileAttrsType = lib.types.attrsOf (
        lib.types.submodule (
          { config, ... }:
          {
            options.mutable = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = ''
                Whether to copy the file without the read-only attribute instead of
                symlinking. If you set this to `true`, you must also set `force` to
                `true`. Mutable files are not removed when you remove them from your
                configuration.

                This option is useful for programs that don't have a very good
                support for read-only configurations.
              '';
            };
          }
        )
      );

    in
    mergeAttrsList (
      map (
        attrPath: lib.setAttrByPath attrPath (lib.mkOption { type = fileAttrsType; })
      ) fileOptionAttrPaths
    );

  config = {
    home.packages = with pkgs; [
      file
      findutils
    ];

    home.activation.mutableFileGeneration =
      let

        allFiles = (
          builtins.concatLists (
            map (attrPath: builtins.attrValues (lib.getAttrFromPath attrPath config)) fileOptionAttrPaths
          )
        );

        filterMutableFiles = builtins.filter (
          file:
          (file.mutable or false)
          && lib.assertMsg file.force "if you specify `mutable` to `true` on a file, you must also set `force` to `true`"
        );

        mutableFiles = filterMutableFiles allFiles;

        toCommand = (
          file:
          let
            source = lib.escapeShellArg file.source;
            target = lib.escapeShellArg file.target;
            recursiveFlag = if (file.recursive or false) then "-r" else "";
          in
          ''
            $VERBOSE_ECHO "Copying mutable file: ${source} -> ${target}"

            if [ -n "${recursiveFlag}" ]; then
              $DRY_RUN_CMD cp -r --remove-destination --no-preserve=mode ${source}/. ${target} || {
                echo "Error: Failed to copy recursive directory ${source} to ${target}"
                exit 1
              }
            else
              $DRY_RUN_CMD cp --remove-destination --no-preserve=mode ${source} ${target} || {
                echo "Error: Failed to copy file ${source} to ${target}"
                exit 1
              }
            fi

            if [ -d ${target} ]; then
              find ${target} -type f -exec sh -c '
                for f do
                  type=$(${pkgs.file}/bin/file -b "$f")
                  if echo "$type" | grep -qE "executable|script" || [[ "$f" =~ \.sh$ ]]; then
                    $DRY_RUN_CMD chmod u+wx "$f" || {
                      echo "Error: Failed to set permissions on $f"
                      exit 1
                    }
                  fi
                done
              ' sh {} +
            else
              type=$(${pkgs.file}/bin/file -b ${target})
              if echo "$type" | grep -qE "executable|script" || [[ ${target} =~ \.sh$ ]]; then
                $DRY_RUN_CMD chmod u+wx ${target} || {
                  echo "Error: Failed to set permissions on ${target}"
                  exit 1
                }
              fi
            fi
          ''
        );

        command =
          ''
            export PATH="${pkgs.file}/bin:${pkgs.findutils}/bin:$PATH"
            echo "Copying mutable home files for $HOME"
          ''
          + lib.concatLines (map toCommand mutableFiles);

      in
      (lib.hm.dag.entryAfter [ "linkGeneration" ] command);
  };
}
