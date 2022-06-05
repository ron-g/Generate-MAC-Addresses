# Generate-MAC-Addresses
This is to generate MAC addresses for xcp-ng VMs.

The OUI prefix is Ascii "Xen", "58:65:6e". This is set with a variable in the script. The sole optional argument is the number of MAC Addresses to create. `openssl` is required.

## Note that this doesn't check for duplicate MACs.


