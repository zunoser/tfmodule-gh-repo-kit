# tfmodule-gh-repo-kit

Reusable OpenTofu module for standardized GitHub repository management.

## Usage

```hcl
module "repository" {
  source = "git::https://github.com/zunoser/tfmodule-gh-repo-kit.git?ref=v0.2.0"

  name        = "example"
  description = "Example repository"
  visibility  = "public"
}
```

Pin the module to a release tag. Renovate can then propose version updates to
consumers.

## General settings

The `general` defaults follow the recommended repository policy. Override a
field only when a repository needs a different setting.

| Field                    | Default  | Notes                                         |
| ------------------------ | -------- | --------------------------------------------- |
| `default_branch`         | `"main"` |                                               |
| `auto_init`              | `true`   | Takes effect only when creating a repository. |
| `homepage_url`           | `null`   | Left unmanaged when null.                     |
| `topics`                 | `null`   | Left unmanaged when null.                     |
| `is_template`            | `false`  |                                               |
| `has_issues`             | `true`   |                                               |
| `has_discussions`        | `false`  |                                               |
| `has_projects`           | `false`  |                                               |
| `has_wiki`               | `false`  |                                               |
| `allow_merge_commit`     | `false`  |                                               |
| `allow_rebase_merge`     | `false`  |                                               |
| `allow_squash_merge`     | `true`   |                                               |
| `delete_branch_on_merge` | `true`   |                                               |
| `vulnerability_alerts`   | `true`   | Dependabot alerts.                            |

When importing an existing repository, set `auto_init = false` and set every
field that differs from the defaults to the repository's current value, so the
first plan changes nothing on GitHub. Move the repository to the defaults in
later, reviewed changes.

## Archived repositories

The module sets `archive_on_destroy`, so destroying a root archives the
repository instead of deleting it. The GitHub provider cannot read vulnerability
alerts on an archived repository, so remove archived repositories from
management instead of keeping them in a root. To archive a managed repository,
destroy its root, then delete the root and its state.

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

Releases are Git tags created from `main`. Choose the next semantic version,
then create and push the tag:

```console
git tag v0.1.0
git push origin v0.1.0
```
