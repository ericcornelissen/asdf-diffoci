<!-- SPDX-License-Identifier: CC0-1.0 -->

# Security Policy

The maintainers of the _asdf-diffoci_ project take security issues seriously.
We appreciate your efforts to responsibly disclose your findings. Due to the
non-funded and open-source nature of the project, we take a best-efforts
approach when it comes to engaging with security reports.

This document should be considered expired after 2026-06-01. If you are reading
this after that date, try to find an up-to-date version in the official source
repository.

## Supported Versions

Only the latest release of the project is supported with security updates.

## Reporting a Vulnerability

To report a security issue either (in order of preference):

- [Report it through GitHub][new github advisory], or
- Send an email to [security@ericcornelissen.dev] with the terms "SECURITY" and
  "asdf-diffoci" in the subject line.

Please do not open a regular issue or Pull Request in the public repository.

To report a security issue in an old version of the project, please report it
publicly. For example, as a regular issue in the public repository. If in doubt,
report the issue privately.

[new github advisory]: https://github.com/ericcornelissen/asdf-diffoci/security/advisories/new
[security@ericcornelissen.dev]: mailto:security@ericcornelissen.dev?subject=SECURITY%20%28asdf-diffoci%29

### What to Include in a Report

Try to include as many of the following items as possible in a security report:

- An explanation of the issue
- A proof of concept exploit
- A suggested severity
- Relevant [CWE] identifiers
- The latest affected version
- The earliest affected version
- A suggested patch

[cwe]: https://cwe.mitre.org/

### Threat Model

The plugin considers the system on which it is running, `asdf`, GitHub, and
`diffoci` to be trusted. Any violation of confidentiality, integrity, or
availability is considered a security issue.

The project considers the GitHub infrastructure and all project maintainers to
be trusted. Any action that is performed on the repository by any other GitHub
user is considered untrusted.

## Advisories

> **Note**: Advisories will be created only for vulnerabilities present in
> released versions of the project.

| ID               | Date       | Affected versions | Patched versions |
| :--------------- | :--------- | :---------------- | :--------------- |
| -                | -          | -                 | -                |

_This table is ordered most to least recent._

## Acknowledgments

We would like to publicly thank the following reporters:

- _None yet_
