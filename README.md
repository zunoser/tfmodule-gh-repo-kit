# tfmodule-gh-repo-kit

Reusable OpenTofu module for standardized GitHub repository management.

## Usage

```hcl
module "repository" {
  source = "git::https://github.com/zunoser/tfmodule-gh-repo-kit.git?ref=v0.1.0"

  name        = "example"
  description = "Example repository"
  visibility  = "public"
}
```

Pin the module to a release tag. Renovate can then propose version updates to
consumers.

## Actions permissions

The module enables Actions and requires pinned actions by default. An
`actions.lock` entry satisfies this requirement for the actions it covers.
Remote reusable workflow calls still need full commit SHAs.

Before upgrading an existing repository, check its Actions settings. To keep
Actions disabled or retain a restrictive action policy, set
`actions_permissions.enabled` or `actions_permissions.allowed_actions` to match
the repository. The default action policy is `all`. Set `actions_permissions = null`
if these settings are already managed elsewhere or you need to defer adoption.
Upgrade the GitHub provider to v6.11 or later in the v6 series before applying.

## Development

Enter the Nix development shell and run the checks:

```console
nix develop
scripts/check
```

GitHub Actions dependencies are recorded in `.github/workflows/actions.lock`.
After editing a workflow, run `gh actions-lock --no-narrow`, review the changes,
and run `gh actions-lock --verify`. Install the extension first with
`gh extension install github/gh-actions-lock --pin v0.4.0`. GitHub validates locked dependencies automatically when workflows run.

Releases are Git tags created from `main`. Choose the next semantic version,
then create and push the tag:

```console
git tag v0.1.0
git push origin v0.1.0
```
