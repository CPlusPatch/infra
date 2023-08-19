{ config, pkgs, stdenv, ... }:

{
  boot.kernel.sysctl = {
    # Restrict kernel pointers
    "kernel.kptr_restrict" = 2;

    "kernel.dmesg_restrict" = 1;

    # Harden JIT
    "net.core.bpf_jit_harden" = 1;

    "dev.tty.ldisc_autoload" = 0;
    "vm.unprivileged_userfaultfd" = 0;

    # Disable loading other kernels at runtime
    "kernel.kexec_load_disabled" = 1;

    # Disable SysRq key
    "kernel.sysrq" = 0;

    "kernel.perf_event_paranoid" = 3;
    "kernel.unprivileged_userns_clone" = 1;

    ## NETWORK

    # SYN flood attack prevention
    #"net.ipv4.tcp_syncookies" = 1;

    # Prevent IP spoofing
    #"net.ipv4.conf.all.rp_filter" = 1;
    #"net.ipv4.conf.default.rp_filter" = 1;

    # MITM attack prevention (disable redirect acceptance)
    #"net.ipv4.conf.all.accept_redirects" = 0;
    #"net.ipv4.conf.default.accept_redirects" = 0;
    #"net.ipv4.conf.all.secure_redirects" = 0;
    #"net.ipv4.conf.default.secure_redirects" = 0;
    #"net.ipv6.conf.all.accept_redirects" = 0;
    #"net.ipv6.conf.default.accept_redirects" = 0;
    #"net.ipv4.conf.all.send_redirects" = 0;
    #"net.ipv4.conf.default.send_redirects" = 0;

    #"net.ipv4.conf.all.forwarding" = 0;
    #"net.ipv4.conf.all.log_martians" = 1;
    #"net.ipv4.conf.default.log_martians" = 1;

    # Clock fingerprinting prevention (disabled ICMP requests)
    "net.ipv4.icmp_echo_ignore_all" = 1;

    # Restrict ptrace usage
    "kernel.yama.ptrace_scope" = 2;

    # ASLR exploit mitigation
    "vm.mmap_rnd_bits" = 32;
    "vm.mmap_rnd_compat_bits" = 16;

    "fs.protected_fifos" = 2;
    "fs.protected_regular" = 2;

    "fs.suid_dumpable" = 0;
  };
}
