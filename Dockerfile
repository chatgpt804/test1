FROM ubuntu:22.04

# Install required packages
RUN apt update && apt install -y \
    qemu-system-x86 \
    qemu-utils \
    wget \
    x11vnc \
    xvfb \
    fluxbox \
    novnc \
    websockify \
    && rm -rf /var/lib/apt/lists/*

# Set up environment variables
ENV DISPLAY=:1
ENV ISO_URL="https://software.download.prss.microsoft.com/dbazure/Win11_24H2_EnglishInternational_x64.iso?t=d03d3ec6-cac9-4345-b11f-5ce4bca11246&P1=1742701991&P2=601&P3=2&P4=W6o1BQ44RPL9%2fcgxGPGt1nDFlelJqvF5JXJd3ahgZTZqEkM9aFJJTsjoSGWlIisz6TK4KNeJC%2bE4cMVdXxH3F%2fBBFYOZZA634N4NENO64diA4NkCcOLGHpNsKjl25%2bUkSIuwu094zi4dGFh%2f0Gi8gFhw7oCZC1UgK6hA8ZoNgjFvC4FGYwf%2bLZdedeCEN6tEDMlm9Jw9OXNy9uC9PYYoZrgmqvR5%2bHW1rn2wZsRAJoVtWnpheFVF8LxCaC%2fCQ6XOBlgq0B%2bNL9DDINEpTOBCpwzfjEwK5nW0UrjjasEph37YVuTja7X%2fbn7TV0CpQpinJCX%2brTcjRAEeg4SgboOPZw%3d%3d"
ENV ISO_FILE="/windows11.iso"

# Download Windows 11 ISO and rename it
RUN wget -O "$ISO_FILE" "$ISO_URL"

# Create a QEMU disk image
RUN qemu-img create -f qcow2 /win11.qcow2 50G

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose noVNC port
EXPOSE 6080

# Start script
CMD ["/start.sh"]
