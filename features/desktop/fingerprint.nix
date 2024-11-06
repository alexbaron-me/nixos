{config, lib, ...}: {
  options.albarn.fingerprint.enable = lib.mkEnableOption "Use Fingerprint for auth, sudo, etc.";

  config.services.fprintd.enable = config.albarn.fingerprint.enable;
}
