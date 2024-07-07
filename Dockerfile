FROM python:3.10.12-slim-bullseye

WORKDIR /app

# Install necessary dependencies
RUN pip install --upgrade pip
RUN apt update && apt install git -y

# Downgrade NumPy to a version compatible with your modules
RUN pip install "numpy<2"

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Install git-lfs and download the Hugging Face model
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && apt-get install git-lfs -y
RUN git clone https://huggingface.co/SamLowe/roberta-base-go_emotions

# Copy the application code
COPY . .

# Start the application
CMD ["python3", "app.py"]
