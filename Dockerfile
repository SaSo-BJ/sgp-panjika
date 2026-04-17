# ============================================================
# Production Dockerfile for Śrī Gadhādhara Parivāra Panjikā
# Optimized for Render deployment
# ============================================================

FROM rocker/r-ver:4.3.2

# Prevent interactive prompts during package install
ENV DEBIAN_FRONTEND=noninteractive

# ------------------------------------------------------------
# Install required system dependencies
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgit2-dev \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# Install required R packages
# ------------------------------------------------------------
RUN R -e "install.packages( \
    c('plumber','memoise','VedicDateTime'), \
    repos='https://cloud.r-project.org/', \
    Ncpus=parallel::detectCores() \
)"

# ------------------------------------------------------------
# Create app directory
# ------------------------------------------------------------
WORKDIR /app

# ------------------------------------------------------------
# Copy application files
# ------------------------------------------------------------
COPY . /app

# ------------------------------------------------------------
# Render provides PORT dynamically
# Default fallback = 10000
# ------------------------------------------------------------
ENV PORT=10000

# ------------------------------------------------------------
# Expose Render-compatible port
# ------------------------------------------------------------
EXPOSE 10000

# ------------------------------------------------------------
# Start Plumber API
# ------------------------------------------------------------
CMD ["R", "-e", "port <- as.numeric(Sys.getenv('PORT', '10000')); pr <- plumber::plumb('plumber.R'); pr$run(host='0.0.0.0', port=port)"]