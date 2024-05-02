FROM python:3.10-slim

WORKDIR /python-docker

COPY requirements.txt requirements.txt

RUN apt-get update && apt-get install -y git ffmpeg
RUN pip3 install -r requirements.txt
RUN pip3 install "git+https://github.com/openai/whisper.git"
RUN pip3 install uvicorn

# This line is to debug and make sure everything is installed correctly
RUN pip3 freeze && echo "PATH: $PATH"

COPY . .

EXPOSE 8000

CMD ["uvicorn", "fastapi_app:app", "--host", "0.0.0.0", "--port", "8000"]
