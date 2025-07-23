_:
{
  # Enable NFS server and export the home storage directory
  services.nfs.server = {
    enable = true;
    # Export /home/cris/storage to all clients with read-write, synchronous writes,
    # no subtree checking, and no root squashing
    exports = ''
      /run/media/cris/storage 192.168.178.0/24(rw,sync,no_subtree_check,no_root_squash)
    '';
  };
}
