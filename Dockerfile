# Use a lightweight Alpine Linux image with Python 3.11
FROM python:3.11-alpine

# Install build dependencies and update package repository
RUN apk add --no-cache build-base && apk update

# Install Python packages using pip
RUN pip install --upgrade pip \
    numpy pandas scikit-learn matplotlib seaborn plotly

# Setup a base final image from miniconda
FROM continuumio/miniconda3 as prefect-conda

# Expose Jupyter Notebook port
EXPOSE 8888

VOLUME /DS_PROJECTS
# Copy requirements.txt (if any) and install project dependencies
COPY requirements.txt /DS_PROJECTS/requirements.txt
WORKDIR /DS_PROJECTS

RUN pip install -r requirements.txt

# Remove unnecessary packages (optional)
# RUN apk del build-base


# docker run -i -t -p 8888:8888 -v /home/tiago/Documentos/DS_PROJECTS/notebooks:/opt/notebooks 695005fc2b26 /bin/bash -c "\
#     jupyter notebook \
#     --notebook-dir=/opt/notebooks --ip='*' --port=8888 \
#     --no-browser --allow-root"


# docker run -i -t -p 8888:8888 -v /home/tiago/Documentos/DS_PROJECTS:/opt/notebooks 695005fc2b26 /bin/bash -c "\
#     jupyter notebook \
#     --ip='*' --port=8888 \
#     --no-browser --allow-root"