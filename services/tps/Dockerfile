FROM python:3.8

COPY . /tps
RUN cd /tps && python -m pip install -r /tps/requirements.txt
CMD ["python", "/tps/app.py"]
