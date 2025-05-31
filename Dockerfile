FROM python:3.10

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget git nodejs npm python3-dev build-essential libzip-dev libxslt-dev libldap2-dev libsasl2-dev libffi-dev libpq-dev libjpeg-dev libxml2-dev libssl-dev

# Install wkhtmltopdf
RUN apt install -y xfonts-75dpi xfonts-base && \
    wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.6/wkhtmltox_0.12.6-1.bionic_amd64.deb && \
    dpkg -i wkhtmltox_0.12.6-1.bionic_amd64.deb || apt-get -f install -y

# Set workdir
WORKDIR /opt/odoo

# Clone Odoo
RUN git clone https://www.github.com/odoo/odoo --depth 1 --branch 18.0 --single-branch .

# Install Python dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy configuration
COPY odoo.conf /etc/odoo.conf

EXPOSE 8069

CMD ["python3", "odoo-bin", "-c", "/etc/odoo.conf"]
