%global cgif_soname  0
%global cgif_version 0.0.1

Name: libcgif
Version: %{cgif_version} 
Release: 1%{?dist}
License: MIT
Requires: glibc
URL: https://github.com/dloebl/cgif
Source0: https://github.com/dloebl/cgif/archive/refs/tags/V%{version}.tar.gz
BuildRequires: meson, ninja-build, gcc
Summary: A fast and lightweight GIF encoder (shared library)

%description
A fast and lightweight GIF encoding library 
that can create GIF animations and static images.

%package devel
Summary: Development files for %{name}
Requires: libcgif = %{version}-%{release}

%description devel
Contains the C header file and libraries necessary
for developing programs using %{name}

%prep
%setup -qn cgif-%{version}

%build
export CFLAGS="%{optflags}"
meson setup build/ --backend ninja --prefix /usr/ --buildtype plain 
meson compile --verbose -C build/

%check
meson test -C build/

%install
meson install --destdir %{buildroot} -C build/

%files
%license LICENSE 
%{_libdir}/%{name}.so.%{cgif_soname}
%{_libdir}/%{name}.so.%{version}

%files devel
%{_libdir}/%{name}.so
%{_libdir}/pkgconfig/cgif.pc
%{_includedir}/cgif.h

%changelog
* Thu Oct 14 2021 Daniel Löbl <dloebl.2000@gmail.com> - 0.0.1-1
- Initial RPM package
