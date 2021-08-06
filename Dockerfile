FROM pytorch/pytorch

# Configure apt and install packages
RUN apt-get update -y && \
    apt-get install -y \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgl1-mesa-dev \
    git \
#    flask \
    # cleanup
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/li

# Clone EasyOCR repo
RUN mkdir "/app" \
    && git clone "https://github.com/elahe-dastan/first-grade.git" "/app" \
    && cd "/app"

RUN apt-get autoremove -y \
    && apt-get clean -y \
# Build
RUN cd "/app" \
    && python setup.py build_ext --inplace -j 4 \
    && python -m pip install -e .

WORKDIR /app

# Run the application
ENTRYPOINT ["python", "cli.py"]
