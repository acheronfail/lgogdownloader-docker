# PLEASE NOTE:

You probably want to use https://github.com/shakeyourbunny/lgogdownloader-docker instead of this one!
This was a Proof of Concept and is slow and bloated. The linked one has had a bit more love!

For more historical info, see: https://github.com/Sude-/lgogdownloader/issues/211

# `lgogdownloader-docker`

It's `lgogdownloader` in a docker image.

Does what it says on the tin.

## Usage

We need to do two things to use this docker image:

1. we need to map `/root/.config/lgogdownloader` since that's where it stores the credentials
2. we need to map `/data` since that's the image's working directory

```bash
docker run -ti \
  -v "$HOME/.config/lgogdownloader:/root/.config/lgogdownloader" \
  -v "$(pwd):/data" \
  acheronfail/lgogdownloader <args>
```

As an example, if you wanted to download everything from your GOG account, you might do this:

```bash
# Running with no args will trigger a login prompt:
docker run -ti -v "$HOME/.config/lgogdownloader:/root/.config/lgogdownloader" acheronfail/lgogdownloader

# Run again to download everything from GOG:
docker run -ti \
  -v "$HOME/.config/lgogdownloader:/root/.config/lgogdownloader" \
  -v "$(pwd):/data" \
  acheronfail/lgogdownloader \
  --download --platform=all --language=all --include=all --save-serials --save-changelogs
```
