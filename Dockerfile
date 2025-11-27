# 1. Use the recommended Jupyter base image
FROM quay.io/jupyter/minimal-notebook:python-3.11

# Use the non-root default user from the base image
USER ${NB_USER}

# 2. Copy the conda lock file into the image
COPY conda-linux-64.lock /tmp/conda-linux-64.lock

# 3. Install the exact conda environment from the lock file into the base env
RUN conda install --yes --name base --file /tmp/conda-linux-64.lock \
    && conda clean --all -f -y

# 4. Set working directory and copy the project code into the image
WORKDIR /home/jovyan/work
COPY . /home/jovyan/work

# 5. Expose Jupyter's port (CMD is inherited from minimal-notebook)
EXPOSE 8888
