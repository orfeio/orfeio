# Multi-stage Dockerfile for building and locally testing the Jekyll (Just the Docs) site
# Usage patterns:
# 1. Live development (auto-regeneration):
#    docker build -t orfeio-site --target dev .
#    docker run --rm -it -p 4000:4000 -v "$PWD":/srv/jekyll orfeio-site
#    Then visit http://localhost:4000
# 2. Produce static site artifact:
#    docker build -t orfeio-site:build --target build .
#    (Artifacts available inside the image at /srv/jekyll/_site)
# 3. Serve static site with Nginx (no Ruby runtime):
#    docker build -t orfeio-site:static --target static .
#    docker run --rm -p 8080:80 orfeio-site:static
#    Then visit http://localhost:8080

ARG RUBY_VERSION=3.1

############################
# Base stage with bundler  #
############################
FROM ruby:${RUBY_VERSION}-slim AS base

# Install build dependencies required by native gems (e.g., ffi)
RUN apt-get update -qq \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      build-essential \
      git \
      ca-certificates \
      tzdata \
 && rm -rf /var/lib/apt/lists/*

# Directory layout expected by Jekyll
WORKDIR /srv/jekyll

## NOTE: Ruby 3.2+ removes the taint/untaint APIs causing Liquid 4.0.3 (pulled by Jekyll 4.3.0) to raise
## `undefined method 'tainted?'`. Using Ruby 3.1 keeps compatibility. Alternative: upgrade Liquid/Jekyll
## when versions that drop the taint call are available, then you can bump RUBY_VERSION again.

# Leverage cached bundle layer by copying only gem metadata first
COPY Gemfile Gemfile.lock ./

ENV BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    JEKYLL_ENV=development

RUN gem install bundler:2.3.9 \
 && bundle _2.3.9_ install --without test --retry $BUNDLE_RETRY --jobs $BUNDLE_JOBS \
 && find $BUNDLE_PATH -name "*.c" -o -name "*.o" -delete 2>/dev/null || true

# Copy remaining site content
COPY . .

############################
# Development / live serve #
############################
FROM base AS dev
# Expose the Jekyll default port
EXPOSE 4000
# Force polling helps inside some volume mount scenarios (esp. Docker Desktop)
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--watch", "--force_polling"]

############################
# Build static site assets  #
############################
FROM base AS build
ENV JEKYLL_ENV=production
RUN bundle exec jekyll build

########################################
# Minimal static image (Nginx) shipping #
########################################
FROM nginx:alpine AS static
# Copy built site from build stage
COPY --from=build /srv/jekyll/_site /usr/share/nginx/html
# Health check (optional simple file existence)
HEALTHCHECK --interval=30s --timeout=3s CMD [ -f /usr/share/nginx/html/index.html ] || exit 1
