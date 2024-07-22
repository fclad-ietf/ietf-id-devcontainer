# Use on Microsoft's Debian-based Go devcontainer to avoid installing by hand
FROM mcr.microsoft.com/devcontainers/base:bookworm

# Install all components needed to build IETF drafts from Markdown
#
# Note: `apt-add-repository` is broken in Debian 12 (likely due to the new apt
# sources file format) so we must use `sed` instead.
RUN sed -i 's/Components: main/Components: main non-free/' /etc/apt/sources.list.d/debian.sources \
  && apt-get update && export DEBIAN_FRONTEND=noninteractive \
  && apt-get -y install --no-install-recommends make ruby curl rfcdiff xml2rfc npm \
  && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
  && gem install kramdown-rfc2629 && npm install -g aasvg
