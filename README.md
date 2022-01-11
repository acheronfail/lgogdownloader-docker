# `lgogdownloader-docker`

It's `lgogdownloader` in a docker image.

Does what it says on the tin.

## Usage

Note, we need to map `$HOME/.config/lgogdownloader` since that's where it stores the credentials.

```bash
docker run -ti -v "$HOME/.config/lgogdownloader:/root/.config/lgogdownloader" acheronfail/lgogdownloader <args>
```

As an example, if you wanted to download everything from your GOG account, you might do this:

```bash
# Running with no args will trigger a login prompt:
docker run -ti \
  -v "$HOME/.config/lgogdownloader:/root/.config/lgogdownloader" acheronfail/lgogdownloader

# Run again to download everything from GOG:
docker run -ti \
  -v "$HOME/.config/lgogdownloader:/root/.config/lgogdownloader" acheronfail/lgogdownloader \
  --download --platform=all --language=all --include=all --save-serials --save-changelogs
```