# ============================================================
# Production Dockerfile for Śrī Gadādhara Parivāra Panjikā
# Optimized for Render deployment
# ============================================================

FROM rocker/r-ver:4.3.2

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# ------------------------------------------------------------
# Install system dependencies (stable + minimal)
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libxml2-dev \
    libgit2-dev \
    build-essential \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# Install R packages (with better reliability)
# ------------------------------------------------------------
RUN R -e "options(repos = c(CRAN = 'https://cloud.r-project.org')); \
          install.packages(c('plumber','memoise'), Ncpus = parallel::detectCores()); \
          install.packages('VedicDateTime', Ncpus = parallel::detectCores())"

# ------------------------------------------------------------
# Set working directory
# ------------------------------------------------------------
WORKDIR /app

# ------------------------------------------------------------
# Copy only necessary files first (better caching)
# ------------------------------------------------------------
COPY plumber.R /app/

# (Optional: copy other required scripts explicitly if needed)
# COPY *.R /app/

# ------------------------------------------------------------
# Copy rest of the project
# ------------------------------------------------------------
COPY . /app

# ------------------------------------------------------------
# Render provides PORT dynamically
# ------------------------------------------------------------
ENV PORT=10000

# ------------------------------------------------------------
# Expose port
# ------------------------------------------------------------
EXPOSE 10000

# ------------------------------------------------------------
# Start Plumber API
# ------------------------------------------------------------
CMD ["R", "-e", "port <- as.numeric(Sys.getenv('PORT', '10000')); pr <- plumber::plumb('plumber.R'); pr$run(host='0.0.0.0', port=port)"]
