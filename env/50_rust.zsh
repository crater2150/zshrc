if which rustup &>/dev/null; then
	export RUST_SRC_PATH=$(rustup run stable rustc --print sysroot)/lib/rustlib/src/rust/src
fi
