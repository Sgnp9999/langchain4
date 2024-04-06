FROM python:3.8

RUN apt-get update && \
    apt-get install -y curl
COPY echo_service.py ./
COPY templates/ ./templates/
RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey \
    | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
RUN curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
    | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
    | tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

RUN apt-get update
RUN apt-get install -y nvidia-container-toolkit
RUN curl -fsSL https://ollama.com/install.sh | sh
RUN ollama serve
RUN ollama pull mistral
RUN pip install --upgrade pip && \
    pip install flask langchain sentence_transformers transformers[torch]
CMD ["python3", "echo_service.py"]
