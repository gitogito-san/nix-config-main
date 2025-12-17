let
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyAXRmWzXs2LKIHd9z3EM+O9tE7HXNmUqLkOZKaG0+1 agenix key"; 
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAVtf69MhvtfaLSmrWdzo3enNdPDpCuSPUpGWqBV64b3 root@lifebook";
in
{
  "./copilot-api-key.age".publicKeys = [ user system ];
  "./gemini-api-key.age".publicKeys = [ user system ];
}