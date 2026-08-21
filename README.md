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

Releases are Git tags created from `main`. Choose the next semantic version,
then create and push the tag:

```console
git tag v0.1.0
git push origin v0.1.0
```
