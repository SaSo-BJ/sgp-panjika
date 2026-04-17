# ============================================================
# Production Dockerfile for Śrī Gadādhara Parivāra Panjikā
# ============================================================

FROM rocker/r-ver:4.3.2

ENV DEBIAN_FRONTEND=noninteractive

# ------------------------------------------------------------
# System dependencies (FIXED)
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libxml2-dev \
    libgit2-dev \
    libsodium-dev \
    build-essential \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# R packages
# ------------------------------------------------------------
RUN R -e "options(repos = c(CRAN = 'https://cloud.r-project.org')); \
          install.packages(c('plumber','memoise'), Ncpus = parallel::detectCores()); \
          install.packages('VedicDateTime', Ncpus = parallel::detectCores())"

# ------------------------------------------------------------
WORKDIR /app

COPY . /app

ENV PORT=10000
EXPOSE 10000

CMD ["R", "-e", "port <- as.numeric(Sys.getenv('PORT', '10000')); pr <- plumber::plumb('plumber.R'); pr$run(host='0.0.0.0', port=port)"]
