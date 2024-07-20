{
	lib,
	stdenv,
	pkg-config,
	meson,
	ninja,
	cmake,
	fmt,
	rustc,
	cargo,
}: let
	inherit (stdenv) hostPlatform;
	isLinuxClang = hostPlatform.isLinux && stdenv.cc.isClang;
in stdenv.mkDerivation (self: {
	pname = "nested-static-libs";
	version = "0.0.1";

	strictDeps = true;
	__structuredAttrs = true;

	src = lib.fileset.toSource {
		root = ./.;
		fileset = lib.fileset.unions [
			./meson.build
			./src
		];
	};

	nativeBuildInputs = [
		pkg-config
		meson
		ninja
		cmake
		rustc
		cargo
	];

	buildInputs = [
		fmt
	];

	dontUseCmakeConfigure = true;

	mesonBuildType = "debugoptimized";
	mesonFlags = lib.optionals isLinuxClang [
		"-Db_lto=false"
	];

	ninjaFlags = [ "-v" ];

	passthru.mkDevShell = {
		mkShell,
		clang-tools,
	}: mkShell {
		inputsFrom = [ self.finalPackage ];
		packages = [ clang-tools ];
	};

	meta = {
		homepage = "https://github.com/Qyriad/nested-static-libs";
		#description = "";
		maintainers = with lib.maintainers; [ qyriad ];
		license = with lib.licenses; [ mit ];
		sourceProvenance = with lib.sourceTypes; [ fromSource ];
		platforms = with lib.platforms; all;
		#mainProgram = "";
	};
})

