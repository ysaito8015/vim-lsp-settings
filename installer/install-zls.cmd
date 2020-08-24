@echo off

setlocal enabledelayedexpansion

git clone --recurse-submodules --depth=1 https://github.com/zigtools/zls .
zls build
move zig-cache\bin\zls.exe
rd /Q /S zig-cache src tests

for /f "usebackq tokens=1 delims==" %%f in (`where zig`) do (
  set "f=%%~dpf"
  set "f=!f:\=/!"
  echo {"zig_lib_path":"!f!lib/zig","enable_snippets":true,"warn_style":true,"enable_semantic_tokens":true} > zls.json
  goto break
)
:break
