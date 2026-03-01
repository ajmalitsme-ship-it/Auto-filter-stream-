
# Use Python 3.10 (required for cinemagoer)
FROM python:3.10-slim-buster

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# Install Python packages
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Create necessary directories
RUN mkdir -p downloads logs

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Command to run the bot
CMD ["python3", "bot.py"]
