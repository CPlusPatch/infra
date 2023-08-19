{ config, pkgs, ... }: { environment.memoryAllocator.provider = "scudo"; }
