use std::fs;
use std::ffi::CString;

#[no_mangle]
pub extern fn get_hostname() -> *const u8
{
	let s: String = fs::read_to_string("/proc/sys/kernel/hostname")
		.unwrap();

	let cstr = CString::new(s).unwrap();

	let leaked = Vec::leak(cstr.into_bytes_with_nul());

	leaked.as_mut_ptr()
}
