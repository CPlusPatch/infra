{ config, pkgs, stdenv, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_hardened;
  boot.kernelParams = [
    # Disable slab merging to prevent heap exploitation
    "slab_nomerge"
    # Enable zeroing memory during allocation and free time
    "init_on_alloc=1"
    "init_on_free=1"
    # Randomize page allocator freelists
    "page_alloc.shuffle=1"
    # Mitigations
    "pti=on"

    "vsyscall=none"
    "debugfs=off"
    "oops=panic"

    # Enable lockdown LSM
    "lockdown=confidentiality"
  ];

  boot.blacklistedKernelModules = [
    "dccp"
    "sctp"
    "rds"
    "tipc"
    "n-hdlc"
    "ax25"
    "netrom"
    "x25"
    "rose"
    "decnet"
    "econet"
    "af_802154"
    "ipx"
    "appletalk"
    "psnap"
    "p8023"
    "p8022"
    "can"
    "atm"

    "cramfs"
    "freevxfs"
    "jffs2"
    "hfs"
    "hfsplus"
    "squashfs"
    "udf"

    "cifs"
    "nfs"
    "nfsv3"
    "nfsv4"
    "ksmbd"
    "gfs2"

    "vivid"
    "dccp"
    "sctp"
    "rds"
    "tipc"
  ];
}
