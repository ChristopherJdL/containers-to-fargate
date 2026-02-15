#python setup.py install; [Environment]::SetEnvironmentVariable("FLASK_APP", "hello"); flask run

# docker
docker build -t containers-to-fargate:local .
docker run -p 8080:8080 containers-to-fargate:local