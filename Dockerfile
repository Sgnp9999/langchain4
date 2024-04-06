ARG BASE_IMAGE=python:3.10-slim-buster
FROM $BASE_IMAGE
COPY echo_service.py ./
COPY templates/ ./templates/
RUN curl -fsSL https://ollama.com/install.sh | sh && \
    ollama pull mistral
RUN pip install --upgrade pip && \
    pip install flask langchain
CMD ["python3", "echo_service.py"]

