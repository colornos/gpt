import subprocess
import sys
import importlib
import pkg_resources

def install_python_package(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

def upgrade_python_package(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", "--upgrade", package])

def install_system_package(package):
    subprocess.check_call(["sudo", "apt-get", "install", "-y", package])

# List of necessary Python packages
python_packages = ["torch", "numpy", "transformers", "datasets", "tiktoken", "wandb", "tqdm"]

# Upgrade pip, setuptools, and wheel
subprocess.check_call([sys.executable, "-m", "pip", "install", "--upgrade", "pip", "setuptools", "wheel"])

for package in python_packages:
    try:
        dist = pkg_resources.get_distribution(package)
        print("{} ({}) is installed".format(dist.key, dist.version))
    except pkg_resources.DistributionNotFound:
        print("{} is NOT INSTALLED".format(package))
        print("Installing {}...".format(package))
        install_python_package(package)
    else:
        print("Checking for updates for {}...".format(package))
        upgrade_python_package(package)

# List of necessary system packages
system_packages = ["vim", "python3-dev", "python3-pip", "libpq-dev"]

for package in system_packages:
    try:
        subprocess.check_call(["dpkg", "-s", package])
        print("{} is installed".format(package))
    except subprocess.CalledProcessError:
        print("{} is NOT INSTALLED".format(package))
        print("Installing {}...".format(package))
        install_system_package(package)
