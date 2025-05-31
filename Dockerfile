FROM python:3.10

# Install system packages
RUN apt-get update && apt-get install -y \
    gcc g++ python3-dev libxml2-dev libxslt1-dev zlib1g-dev \
    libsasl2-dev libldap2-dev build-essential \
    libjpeg-dev libpq-dev libffi-dev \
    xfonts-75dpi xfonts-base \
    wget git nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /opt/odoo

# Copy Odoo source into container
COPY ./odoo-18.0/ .

# Copy config file and requirements
COPY requirements.txt .
COPY odoo.conf /etc/odoo.conf

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

EXPOSE 8069

# Start Odoo
CMD ["python3", "odoo-bin", "-c", "/etc/odoo.conf"]
