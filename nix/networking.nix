_: {
  # Open required ports
  networking.firewall.allowedTCPPorts = [
    8053  # Pi-hole web interface
    53    # DNS

    443   # Caddy Pi-hole web interface (HTTPS)
    80    # Caddy - Reverse proxy

    8054  # Sane Web UI
  ];

  networking.firewall.allowedUDPPorts = [
    53    # DNS

    # 67    # DHCP (if you plan to use Pi-hole as DHCP server)
  ];
}
