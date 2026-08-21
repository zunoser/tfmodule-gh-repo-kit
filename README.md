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

## Development

Enter the Nix development shell and run the checks:

```console
nix develop
scripts/check
```

Releases are managed by tagpr from Conventional Commit messages merged into
`main`.
