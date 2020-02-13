if which rustup &>/dev/null && [[ -n $(rustup show active-toolchain) ]]; then
	export RUST_SRC_PATH=$(rustup run stable rustc --print sysroot)/lib/rustlib/src/rust/src
fi
