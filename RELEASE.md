<!-- SPDX-License-Identifier: CC0-1.0 -->

# Release Guidelines

To release a new version of the _asdf-diffoci_ project follow the description in
this file (using v1.0.1 as an example):

1. Make sure that your local copy of the repository is up-to-date, sync:

   ```shell
   git checkout main
   git pull origin main
   ```

   Or clone:

   ```shell
   git clone git@github.com:ericcornelissen/asdf-diffoci.git
   ```

1. Run `make release v=1.0.1`

   > **Note** At this point, the continuous delivery automation may pick up and
   > complete the release process. If not, or only partially, continue following
   > the remaining steps.

1. Create a [GitHub Release] for the git tag of the new release. The release
   title and text should both be "Release {_version_}" (e.g. "Release v1.0.1").

[github release]: https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository
