# ligDream on nvidia-docker container

This is to run ligDream on nvidia-docker.

### Requisite

- CUDA8.0 (also 9.1) compatible nvidia driver

### Major installation items

- Virtual environment of Python3.6
- rdkit 2017.09.2.0 (conda install -y -c rdkit rdkit=2017.09.2.0)
- pytorch 0.3.1 of cuda91 build (conda install -y -c pytorch pytorch=0.3.1 cuda91)
- keras 2.2.2 (conda install -y -c conda-forge keras=2.2.2)
- htmd 1.13.9, psi4 1.2.1, pcmsolver 1.2.1 (conda install -y -c acellera -c psi4 psi4=1.2.1 pcmsolver=1.2.1 htmd=1.13.9)

### Some notes

- Login directly brings you in python3.6 environment
- Jupyter notebook is modified to allow root and from ip 0.0.0.0
- ligdream is cloned and add PYTHONPATH for ready use

### Typical build procedure

Be warned that downloading data will take some while (zinc15_druglike_clean_canonical_max60.zip = 1.6GB, ligdream-20190128T143457Z-001.zip = 182MB).

Data will be copied into container. getData.sh does continued downloading after any interruption (wget -c).

```
bash getData.sh
nvidia-docker build -t ligdream_nvidia/cuda8.0:0.1 -f Dockerfile.cuda80 .
```

### Typical run the container

Always convenient if container has mountpoint to host directory.

```
nvidia-docker run -ti -v $PWD:/supp -p 8888:8888 h_nvidia/cuda8.0:0.1
```

### Testing

```
$ cd ligdream
$ head -10000 traindataset/zinc15_druglike_clean_canonical_max60.smi > test10000.smi
$ python prepare_data.py -i test10000.smi -o test10000.npy
100%|##########################################################################################################| 10000/10000 [00:01<00:00, 5351.14it/s]
$ python train.py -i test10000.npy -o models
SmallMol module is in beta version
Using TensorFlow backend.
Traceback (most recent call last):
  File "train.py", line 44, in <module>
    decoder.cuda()
  File "/root/miniconda3/envs/py36/lib/python3.6/site-packages/torch/nn/modules/module.py", line 216, in cuda
    return self._apply(lambda t: t.cuda(device))
  File "/root/miniconda3/envs/py36/lib/python3.6/site-packages/torch/nn/modules/module.py", line 146, in _apply
    module._apply(fn)
  File "/root/miniconda3/envs/py36/lib/python3.6/site-packages/torch/nn/modules/rnn.py", line 123, in _apply
    self.flatten_parameters()
  File "/root/miniconda3/envs/py36/lib/python3.6/site-packages/torch/nn/modules/rnn.py", line 111, in flatten_parameters
    params = rnn.get_parameters(fn, handle, fn.weight_buf)
  File "/root/miniconda3/envs/py36/lib/python3.6/site-packages/torch/backends/cudnn/rnn.py", line 165, in get_parameters
    assert filter_dim_a.prod() == filter_dim_a[0]
AssertionError
```
