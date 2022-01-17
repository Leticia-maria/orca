## Dockerfile for ORCA 🐳 🐋

![3b676bf7d59310b9f6a2e10e51a56474](https://user-images.githubusercontent.com/60739184/149775497-2a6ef4f0-6784-4ac6-bb17-8f3f9670f8ce.gif)

An automated way to install Orca software for quantum chemical calculations.

### Installed dependencies
 - [conda](https://docs.conda.io/en/latest/)
 - [pip](https://pypi.org/project/pip/)
 - [xtb](https://github.com/grimme-lab/xtb)
 - [autoDE](https://github.com/duartegroup/autodE)
 - [orca](https://www.orcasoftware.de/tutorials_orca/first_steps/input_output.html) (5.0.2 version)

For further information, check out the [documentation of ORCA software](https://orcaforum.kofo.mpg.de/app.php/portal)

### Usage

To use this docker container, you can pull the image from [DockerHub](https://hub.docker.com/) or [GitHub Container Registries](https://docs.github.com/pt/packages/working-with-a-github-packages-registry/working-with-the-container-registry)

- DockerHub

```shell
docker pull leticiamaria/orca:5.0.2
```

- GitHub Container Registries

```shell
docker pull ghcr.io/leticia-maria/orca:5.0.2
```

To run inside of your computer:

```shell
docker run -t -i leticia-maria/orca:5.0.2 /bin/bash
```

```shell
source /opt/orcainit5
```

```shell
orca *.inp
```

### References 

Please, don't forget to reference ORCA software in your paper:

NEESE2020: https://onlinelibrary.wiley.com/doi/full/10.1002/jcc.26139
