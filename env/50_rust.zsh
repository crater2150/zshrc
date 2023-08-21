export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export PATH="${CARGO_HOME}/bin:${PATH}"
if which rustup &>/dev/null && [[ -n $(rustup show active-toolchain) ]]; then
	export RUST_SRC_PATH=$(rustup run stable rustc --print sysroot)/lib/rustlib/src/rust/src
fi
