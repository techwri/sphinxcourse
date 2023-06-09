# Используйте базовый образ Python
FROM python:3.9

# Установите Sphinx
RUN pip install Sphinx

# Скопируйте содержимое проекта в образ
COPY . /app

# Установите зависимости проекта
RUN pip install -r /app/requirements.txt

# Установите обязательные пакеты
RUN apt-get update && apt-get install -y make

# Установите рабочую директорию
WORKDIR /app

# Сгенерируйте документацию
RUN make html

# Указать порт, который будет прослушиваться в контейнере
EXPOSE 8000

# Запустите веб-сервер для отображения документации
CMD ["python", "-m", "http.server", "8000", "--directory", "build/html"]
