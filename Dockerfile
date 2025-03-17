FROM python:latest
#Installingdependenciesfor running apythonapplication
RUN apt-get update && apt-get install -y pipx
RUN pipx ensurepath

#Install poetry
RUN pipx install poetry
#Setting the workingdirectory
WORKDIR /app
#Install poetry dependencies
COPY pyproject.toml ./
RUN pipx run poetry install --no-root

#Copying our application intothecontainer
COPY todo todo

#Running our application
CMD ["pipx","run", "poetry", "run", "flask","--app","todo","run",\
"--host","0.0.0.0","--port", "6400"]

# Adding a delay to our application startup
CMD ["bash", "-c", "sleep 10 && pipx run poetry run flask--app todo run \--host 0.0.0.0--port 6400"]