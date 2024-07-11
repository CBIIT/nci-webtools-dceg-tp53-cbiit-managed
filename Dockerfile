FROM public.ecr.aws/amazonlinux/amazonlinux:2023

RUN dnf -y update && \
    dnf -y install \
    gcc \
    pkgconf \
    pkgconf-pkg-config \
    python3-devel \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    && dnf clean all

RUN mkdir /app

WORKDIR /app

COPY requirements.txt .

RUN python3 -m pip install -r requirements.txt

COPY . .

ENV PYTHONUNBUFFERED=1

ENV PORT=8080

CMD gunicorn -t 120 -b :$PORT main:app
