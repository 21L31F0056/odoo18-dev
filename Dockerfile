FROM python:3.10

# Install system packages
RUN apt-get update && apt-get install -y \
    wget git nodejs npm python3-dev build-essential libzip-dev libxslt-dev \
    libldap2-dev libsasl2-dev libffi-dev libpq-dev libjpeg-dev libxml2-dev \
    libssl-dev xfonts-75dpi xfonts-base && \
    wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.6/wkhtmltox_0.12.6-1.bionic_amd64.deb && \
    dpkg -i wkhtmltox_0.12.6-1.bionic_amd64.deb || apt-get -f install -y

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
