# nvidia-docker-test

This is to run ligDream on nvidia-docker.

Requisite:

    - CUDA9.1 compatible nvidia driver

Major installation items:

    - Virtual environment of Python3.5
    - rdkit 2017.09.2.0 (conda install -y -c rdkit rdkit=2017.09.2.0)
    - pytorch 0.3.1 of cuda91 build (conda install -y -c pytorch pytorch=0.3.1 cuda91)
    - keras 2.2.2 (conda install -y -c conda-forge keras=2.2.2)
    - htmd 1.13.9, psi4 1.2.1, pcmsolver 1.2.1 (conda install -y -c acellera -c psi4 psi4=1.2.1 pcmsolver=1.2.1 htmd=1.13.9)

Some notes:

    - Login directly brings you in python3.5 environment
    - Jupyter notebook is modified to allow root and from ip 0.0.0.0
    - ligdream is cloned and add PYTHONPATH for ready use
