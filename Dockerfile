FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
# Ejecuta el archivo main dentro de la carpeta app
CMD ["python", "app/main.py"]