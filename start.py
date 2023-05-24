import subprocess
import sys

def install(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

# List of necessary packages
packages = ["torch", "numpy", "transformers", "datasets", "tiktoken", "wandb", "tqdm"]

for package in packages:
    try:
        dist = __import__(package)
        print("{} ({}) is installed".format(dist.__name__, dist.__version__))
    except ImportError:
        print("{} is NOT INSTALLED".format(package))
        print("Installing {}...".format(package))
        install(package)
