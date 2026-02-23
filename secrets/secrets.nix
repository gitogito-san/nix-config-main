let
  ya = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyAXRmWzXs2LKIHd9z3EM+O9tE7HXNmUqLkOZKaG0+1 agenix key";
  lifebook = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAVtf69MhvtfaLSmrWdzo3enNdPDpCuSPUpGWqBV64b3 root@lifebook";
  trigkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILgCgv4oqNNnKjHQrSEU6LXt33yKhV/35tz5FZhFrAVW root@trigkey";

  allSystems = [
    lifebook
    trigkey
  ];
in
{
  "./copilot-api-key.age".publicKeys = [
    ya
  ]
  ++ allSystems;
  "./gemini-api-key.age".publicKeys = [
    ya
  ]
  ++ allSystems;
}
