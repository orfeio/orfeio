---
title: SSH Public Key Authentication
layout: default 
nav_order: 2
---

# SSH Public Key Authentication

SSH public key authentication is a secure way to authenticate that eliminates the need to communicate a password.

Each device, such as your device and the system requiring authentication, generates a public key and a private key.  These are stored as files.

Your public key file is placed on the system requiring authentication, while the remote system transfers its public key to you on your first connection attempt.

Information encrypted with the public key can only be decrypted using the private key.

To authenticate, the remote system sends your device a challenge encrypted with the public key.  If your device can decrypt the challenge and provide the correct response, you're granted access, all without ever being prompted to input credentials.

## Setup

### macOS

1. Open the Terminal app and type `ssh-keygen -t ed25519` to begin generating your public and private keys.
2. Press the Enter key to accept the default location to save the file.
3. Type a passphrase.  This passphrase secures the private key from unauthorized use and never leaves your device, but it should meet [good practice for password complexity](https://bitwarden.com/password-generator/).[^phrase]
4. Type `open ~/.ssh` to open the the folder containing the key files in the Finder.  If you used the default filename to save the file(s), the public key will be named `id_ed25519.pub`.
5. Transfer the public key to the remote system (or [an administrator if you need assistance](https://orfe.princeton.edu/it/upload)) and place it inside the `.ssh` folder.  Rename it to `authorized_keys` or append its contents to an existing `authorized_keys` file.[^keytrans]
6. Type `ssh-add` into the Terminal to load your private key for use.  If prompted for the passphrase, provide it.


Provided your public key has been transferred, you have loaded your private key, and you utilize the correct username, you can now establish an SSH connection to the remote system without having to present a password for authentication.

[^phrase]: The system's Keychain can be used to store the passphrase, as can any good password manager.  Should you lose the record of the passphrase, you can delete your keys and generate them anew.
[^keytrans]: Only ever share the public key; your private key secures your connection.  You can upload or email your public key to any individual or system to which you are trying to secure a connection. 
