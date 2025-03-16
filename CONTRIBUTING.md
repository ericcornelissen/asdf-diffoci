<!-- SPDX-License-Identifier: CC0-1.0 -->

# Contributing Guidelines

The maintainers of _asdf-diffoci_ welcome contributions and corrections. This
includes improvements to the documentation or code base, tests, bug fixes, and
implementations of new features. We recommend you open an issue before making
any substantial changes so you can be sure your work won't be rejected. But for
small changes, such as fixing a typo, you can open a Pull Request directly.

If you decide to make a contribution, please use the following workflow:

- Fork the repository.
- Create a new branch from the latest `main`.
- Make your changes on the new branch.
- Commit to the new branch and push the commit(s).
- Open a Pull Request against `main`.

## Security

For security related issues, please refer to the [security policy].

## Prerequisites

To be able to contribute you need the following tooling:

- [Git];
- [Make];
- [asdf];
- (Recommended) a code editor with [EditorConfig] support;
- (Optional) [actionlint] (see `.tool-versions` for preferred version);
- (Optional) [Docker] or [Podman] (development environment available)
- (Optional) [hadolint] (see `.tool-versions` for preferred version);
- (Optional) [ShellCheck] (see `.tool-versions` for preferred version);
- (Optional) [shfmt] (see `.tool-versions` for preferred version);

[actionlint]: https://github.com/rhysd/actionlint
[asdf]: https://asdf-vm.com/
[docker]: https://www.docker.com/
[editorconfig]: https://editorconfig.org/
[git]: https://git-scm.com/
[hadolint]: https://github.com/hadolint/hadolint
[make]: https://www.gnu.org/software/make/
[podman]: https://podman.io/
[security policy]: ./SECURITY.md
[shellcheck]: https://github.com/koalaman/shellcheck
[shfmt]: https://github.com/mvdan/sh
