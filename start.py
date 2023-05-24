import subprocess
import sys
import importlib

def install_python_package(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

def install_system_package(package):
    subprocess.check_call(["sudo", "apt-get", "install", "-y", package])

# List of necessary Python packages
python_packages = ["torch", "numpy", "transformers", "datasets", "tiktoken", "wandb", "tqdm"]

for package in python_packages:
    try:
        dist = importlib.import_module(package)
        print("{} ({}) is installed".format(dist.__name__, dist.__version__))
    except ImportError:
        print("{} is NOT INSTALLED".format(package))
        print("Installing {}...".format(package))
        install_python_package(package)

# Check for vim
try:
    subprocess.check_call(["vim", "--version"])
    print("vim is installed")
except subprocess.CalledProcessError:
    print("vim is NOT INSTALLED")
    print("Installing vim...")
    install_system_package("vim")
