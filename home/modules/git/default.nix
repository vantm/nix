{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Van Tran";
      user.email = "tmvan.1903@gmail.com";
      init.defaultBranch = "master";
      pull.ff = "only";
      merge.conflictStyle = "zdiff3";
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/gh_id_ed25519";
      };
    };
  };
}
