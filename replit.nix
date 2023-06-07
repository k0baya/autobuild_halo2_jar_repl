{ pkgs }: {
	deps = [
		pkgs.busybox
    pkgs.nodejs-18_x
    pkgs.jdk17_headless
    pkgs.nodePackages.typescript-language-server
    pkgs.yarn
    pkgs.replitPackages.jest
	];
}
