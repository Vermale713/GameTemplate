# Game Template

Generated with argon

## Getting Started

### Required

Make a config in your experience storing the admins.

To build the place in the project root use:

```bash
argon build
```

To begin syncing open Roblox Studio and start the Argon server using:

```bash
argon serve
```

### Charm Sync

This is the replication I am opting for. If you are also opting for it and do not want to use Blink, you can remove Blink. Or if you do not care about the squash optimizations, you can just change the data type in the Blink config for the sync event to `unknown`.
