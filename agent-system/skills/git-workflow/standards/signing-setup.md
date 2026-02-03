# SSH Signing Setup

Guide for configuring SSH commit signing. SSH signing is the recommended method for its simplicity compared to GPG.

## Overview

Commit signing cryptographically verifies that commits were made by you. GitHub displays a "Verified" badge on signed commits.

| Platform | Signing Support |
| -------- | --------------- |
| GitHub | ✅ Supported and required |
| Azure DevOps | ❌ No verification support |

---

## Setup Steps

### 1. Generate an SSH Key

If you don't have an SSH key, generate one:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

**Prompts:**

- File location: Press Enter for default (`~/.ssh/id_ed25519`)
- Passphrase: Enter a secure passphrase (recommended)

### 2. Add Key to GitHub

Copy your public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Add to GitHub:

1. Go to **GitHub → Settings → SSH and GPG keys**
2. Click **New SSH key**
3. Select **Signing Key** as the key type
4. Paste your public key
5. Click **Add SSH key**

> **Note:** You can use the same key for both authentication and signing, but you must add it twice — once as an "Authentication Key" and once as a "Signing Key".

### 3. Configure Git

Tell Git to use SSH for signing:

```bash
# Set signing format to SSH
git config --global gpg.format ssh

# Set your signing key (path to PRIVATE key)
git config --global user.signingkey ~/.ssh/id_ed25519

# Enable signing by default
git config --global commit.gpgsign true
```

### 4. Create Allowed Signers File (Optional)

For local signature verification:

```bash
# Create allowed signers file
echo "your_email@example.com $(cat ~/.ssh/id_ed25519.pub)" >> ~/.ssh/allowed_signers

# Tell Git where to find it
git config --global gpg.ssh.allowedSignersFile ~/.ssh/allowed_signers
```

---

## Verification

### Check Configuration

```bash
# Verify signing key is set
git config --get user.signingkey

# Verify signing is enabled
git config --get commit.gpgsign

# Verify format is SSH
git config --get gpg.format
```

Expected output:

```text
/home/user/.ssh/id_ed25519
true
ssh
```

### Test Signing

```bash
# Create a test commit
echo "test" >> test.txt
git add test.txt
git commit -m "test: verify signing works"

# Verify the signature
git log --show-signature -1
```

Look for output containing:

```text
Good "git" signature for your_email@example.com
```

### Verify on GitHub

After pushing, check the commit on GitHub. Signed commits display a green "Verified" badge.

---

## Troubleshooting

### "error: Load key ... invalid format"

**Cause:** Pointing to public key instead of private key.

**Fix:** Use the private key path (without `.pub`):

```bash
git config --global user.signingkey ~/.ssh/id_ed25519  # Not id_ed25519.pub
```

### "error: ssh-keygen -Y sign is not available"

**Cause:** OpenSSH version too old (requires 8.0+).

**Fix:** Update OpenSSH:

```bash
# macOS
brew install openssh

# Ubuntu/Debian
sudo apt update && sudo apt install openssh-client
```

### Commits Not Showing as Verified on GitHub

**Possible causes:**

1. Key not added as "Signing Key" on GitHub (only as Authentication Key)
2. Email in Git config doesn't match GitHub account email
3. Key not yet propagated (wait a few minutes)

**Fix:** Verify email matches:

```bash
git config --get user.email
```

Ensure this email is verified on your GitHub account.

### Signing Fails in DevContainer

**Cause:** SSH agent not forwarded or key not available.

**Fix:** Ensure SSH agent forwarding is configured in your DevContainer:

```json
{
  "mounts": [
    "source=${localEnv:HOME}/.ssh,target=/home/vscode/.ssh,type=bind,readonly"
  ]
}
```

Or use SSH agent forwarding in your VS Code settings.

---

## Quick Reference

| Command | Purpose |
| ------- | ------- |
| `git config --global gpg.format ssh` | Use SSH for signing |
| `git config --global user.signingkey ~/.ssh/id_ed25519` | Set signing key |
| `git config --global commit.gpgsign true` | Enable auto-signing |
| `git log --show-signature -1` | Verify last commit signature |
| `git verify-commit HEAD` | Verify HEAD commit |

---

## References

- [GitHub: Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [GitHub: Telling Git about your SSH key](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key)
- [GitHub: Signing commits](https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits)
