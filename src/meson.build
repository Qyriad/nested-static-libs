libhostname = static_library(
  'hostname',
  rust_abi : 'c',
  sources : files('hostname.rs'),
  install : true,
)

libhostname_dep = declare_dependency(
  link_with : libhostname,
)

libfrob = static_library(
  'frob',
  sources : files(
    'libfrob.cpp',
  ),
  install : true,
  #link_with : libhostname,
  dependencies : [
    libhostname_dep,
  ],
)

libfrob_dep = declare_dependency(
  include_directories : include_directories('.'),
  link_with : libfrob,
)

srcs = files(
  'main.cpp',
)

executable(
  'nested-static-libs',
  srcs,
  dependencies : [fmtlib, libfrob_dep],
  install : true,
  #link_with : libfrob,
)
